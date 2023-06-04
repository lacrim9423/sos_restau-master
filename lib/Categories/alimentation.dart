// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/class/produit.dart';
import 'package:flash/flash.dart';
import 'package:sos_restau/historique.dart';
import 'package:sos_restau/home.dart';
import 'package:sos_restau/panier.dart';
import 'package:sos_restau/profile.dart';
import '../models/product_card.dart';

class GroceryCategoryPage extends StatefulWidget {
  const GroceryCategoryPage({Key? key}) : super(key: key);

  @override
  _GroceryCategoryPageState createState() => _GroceryCategoryPageState();
}

class _GroceryCategoryPageState extends State<GroceryCategoryPage> {
  void _goToPanier(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage(userId: userId)),
    );
  }

  void _goToHome(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  void _goToCommandes(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderHistoryPage(userId: userId)),
    );
  }

  void _goToProfile(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  final List<Product> _products = [];
  void _fetchalimentationFromFirestore() {
    FirebaseFirestore.instance
        .collection('Products')
        .where('catégorie', isEqualTo: 'alimentation')
        .get()
        .then((querySnapshot) {
      final alimentation = querySnapshot.docs.map((doc) {
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
        _products.addAll(alimentation);
      });
    }).catchError((error) {
      if (kDebugMode) {
        print('Failed to fetch fruits: $error');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchalimentationFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';

    return Scaffold(
        appBar: AppBar(
          title: const Text('Épicerie'),
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
              description: '',
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

class ProductCard extends StatefulWidget {
  final Product product;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final bool available;

  const ProductCard({
    Key? key,
    required this.product,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.available,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              widget.product.image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Price: ${widget.product.price}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Quantity:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _quantity = _quantity > 0 ? _quantity - 1 : 0;
                            });
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(
                          '$_quantity',
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _quantity += 1;
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Get the current user ID.
                    final currentUser = FirebaseAuth.instance.currentUser;
                    final userId = currentUser != null ? currentUser.uid : '';

                    // Call the addItemToCart function with the necessary arguments.
                    addItemToCart(
                      userId,
                      widget.product.name,
                      _quantity,
                      widget.product.price,
                      widget.product.image,
                    );
                    showFlash(
                      context: context,
                      duration: const Duration(seconds: 2),
                      builder: (_, controller) {
                        return Flash(
                          controller: controller,
                          behavior: FlashBehavior.floating,
                          position: FlashPosition.bottom,
                          margin: const EdgeInsets.all(16),
                          borderRadius: BorderRadius.circular(8),
                          backgroundColor: Colors.grey[900]!,
                          child: const DefaultTextStyle(
                            style: TextStyle(color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text('Produit ajouté au panier!'),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        widget.product.available
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                  ),
                  child: Text(widget.product.available
                      ? 'Ajouter au panier'
                      : 'Indisponible'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
