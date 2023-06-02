// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:sos_restau/models/product_card.dart';
import 'package:sos_restau/class/produit.dart';
import 'package:sos_restau/historique.dart';
import 'package:sos_restau/home.dart';
import 'package:sos_restau/panier.dart';
import 'package:sos_restau/profile.dart';

class FruitCategoryPage extends StatefulWidget {
  const FruitCategoryPage({Key? key}) : super(key: key);

  @override
  _FruitCategoryPageState createState() => _FruitCategoryPageState();
}

class _FruitCategoryPageState extends State<FruitCategoryPage> {
  final List<Product> _products = [
    Product(
      id: "1",
      name: 'Apple',
      description: 'A juicy and delicious fruit',
      price: 1.99,
      image: 'assets/images/fruits/apple.jpeg',
      available: true,
    ),
    Product(
      id: '2',
      name: 'Banana',
      description: 'A sweet and nutritious fruit',
      price: 0.99,
      image: 'assets/images/fruits/banana.jpeg',
      available: false,
    ),
    Product(
      id: '3',
      name: 'Orange',
      description: 'A tangy and refreshing fruit',
      price: 2.49,
      image: 'assets/images/fruits/orange.jpeg',
      available: true,
    ),
    Product(
      id: '4',
      name: 'Strawberry',
      description: 'A small and tasty fruit',
      price: 3.99,
      image: 'assets/images/fruits/strawberry.jpeg',
      available: true,
    ),
    Product(
      id: '5',
      name: 'mango',
      description: 'A small and tasty fruit',
      price: 3.99,
      image: 'assets/images/fruits/mango.jpeg',
      available: true,
    ),
    Product(
      id: '6',
      name: 'peach',
      description: 'A small and tasty fruit',
      price: 3.99,
      image: 'assets/images/fruits/peach.jpeg',
      available: true,
    ),
    Product(
      id: '7',
      name: 'pineapple',
      description: 'A small and tasty fruit',
      price: 3.99,
      image: 'assets/images/fruits/pineapple.jpeg',
      available: true,
    ),
    Product(
      id: '8',
      name: 'watermelon',
      description: 'A small and tasty fruit',
      price: 3.99,
      image: 'assets/images/fruits/watermelon.jpeg',
      available: true,
    ),
    Product(
      id: '9',
      name: 'kiwi',
      description: 'A small and tasty fruit',
      price: 5.99,
      image: 'assets/images/fruits/kiwi.jpeg',
      available: true,
    ),
    Product(
      id: '10',
      name: 'grape',
      description: 'A small and tasty fruit',
      price: 1.50,
      image: 'assets/images/fruits/grape.jpeg',
      available: true,
    ),
  ];
  void _goToPanier(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage(userId: userId)),
    );
  }

  void _goToHome(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const HomePage(
                userId: '',
              )),
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

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';

    return Scaffold(
        appBar: AppBar(
          title: const Text('Grocery Category'),
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
