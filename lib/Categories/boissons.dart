// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/class/produit.dart';
import 'package:sos_restau/historique.dart';
import 'package:sos_restau/home.dart';
import 'package:sos_restau/panier.dart';
import 'package:sos_restau/profile.dart';

import '../models/product_card.dart';

class DrinkCategoryPage extends StatefulWidget {
  const DrinkCategoryPage({Key? key}) : super(key: key);

  @override
  _DrinkCategoryPageState createState() => _DrinkCategoryPageState();
}

class _DrinkCategoryPageState extends State<DrinkCategoryPage> {
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
  void _fetchBoissonsFromFirestore() {
    FirebaseFirestore.instance
        .collection('Products')
        .where('catégorie', isEqualTo: 'boissons')
        .get()
        .then((querySnapshot) {
      final boissons = querySnapshot.docs.map((doc) {
        final data = doc.data();

        return Product(
          name: data['nom'],
          description: data['description'],
          price: data['prix'],
          image: data['image'],
          available: data['disponible'],
        );
      }).toList();

      setState(() {
        _products.addAll(boissons);
      });
    }).catchError((error) {
      if (kDebugMode) {
        print('Failed to fetch boissons: $error');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchBoissonsFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boissons'),
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
        itemBuilder: (BuildContext context, int index) {
          final drink = _products[index];
          return ProductCard(
            product: drink,
            title: drink.name,
            description: drink.description,
            imageUrl: drink.image,
            price: drink.price,
            available: drink.available,
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
                _goToHome(context,
                    userId); // Invoke the function by adding parentheses and passing context and userId
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
      ),
    );
  }
}
