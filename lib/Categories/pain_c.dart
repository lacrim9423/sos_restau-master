import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/class/pain.dart';
import 'package:sos_restau/class/produit.dart';
import 'package:sos_restau/models/pain_card.dart';
import 'package:sos_restau/historique.dart';
import 'package:sos_restau/home.dart';
import 'package:sos_restau/panier.dart';
import 'package:sos_restau/profile.dart';

import '../models/product_card.dart';

class BreadCategoryPage extends StatefulWidget {
  const BreadCategoryPage({Key? key}) : super(key: key);

  @override
  _BreadCategoryPageState createState() => _BreadCategoryPageState();
}

class _BreadCategoryPageState extends State<BreadCategoryPage> {
  void _goToPanier(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage(userId: userId)),
    );
  }

  void _goToCommandes(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderHistoryPage(userId: userId)),
    );
  }

  void _goToHome(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void _goToProfile(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  final List<Product> _products = [];
  void _fetchpainFromFirestore() {
    FirebaseFirestore.instance
        .collection('Products')
        .where('catégorie', isEqualTo: 'pain')
        .get()
        .then((querySnapshot) {
      final pain = querySnapshot.docs.map((doc) {
        final data = doc.data();
        final disponible = data['disponible'] as bool? ??
            false; // Use a null check and provide a default value

        if (data.containsKey('disponible')) {
          return Product(
            name: data['nom'],
            description: data['description'],
            price: data['prix'],
            image: data['image'],
            available: disponible,
          );
        } else {
          // Handle case where 'disponible' field is missing or null
          return Product(
            name: data['nom'],
            description: data['description'],
            price: data['prix'],
            image: data['image'],
            available: false, // Provide a default value in this case
          );
        }
      }).toList();

      setState(() {
        _products.addAll(pain);
      });
    }).catchError((error) {
      if (kDebugMode) {
        print('Failed to fetch veggies: $error');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchpainFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';

    return Scaffold(
        appBar: AppBar(
          title: const Text('Breads'),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: _products.length,
          itemBuilder: (context, index) {
            final product = _products[index];

            return ProductCard(
              product: product,
              title: product.name,
              description: product.description,
              imageUrl: product.image,
              price: product.price,
              available: product.available,
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.orange.shade50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  _goToHome;
                },
                icon: const Icon(Icons.home),
              ),
              IconButton(
                onPressed: () {
                  _goToPanier(context, userId);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              IconButton(
                onPressed: () {
                  _goToCommandes(context, userId);
                },
                icon: const Icon(Icons.history),
              ),
              IconButton(
                onPressed: () {
                  _goToProfile(context, userId);
                },
                icon: const Icon(Icons.person),
              ),
            ],
          ),
        ));
  }
}
