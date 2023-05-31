import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/class/pain.dart';
import 'package:sos_restau/models/pain_card.dart';
import 'package:sos_restau/historique.dart';
import 'package:sos_restau/home.dart';
import 'package:sos_restau/panier.dart';
import 'package:sos_restau/profile.dart';

class BreadCategoryPage extends StatelessWidget {
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
      MaterialPageRoute(
          builder: (context) => HomePage(
                userId: '',
              )),
    );
  }

  void _goToProfile(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  final List<Bread> breads = [
    const Bread(
      id: '1',
      name: 'Baguette',
      description: 'Traditional French baguette, freshly baked every day.',
      image: 'assets/images/baguette.png',
      price: 1.99,
      available: true,
      increment: 10,
    ),
    const Bread(
      id: '2',
      name: 'Tortilla',
      description:
          'Soft and fluffy tortilla, perfect for your favorite fillings.',
      image: 'assets/images/tortilla.png',
      price: 0.99,
      available: true,
      increment: 10,
    ),
    const Bread(
      id: '3',
      name: 'Chawarma',
      description: 'Thin and crispy chawarma bread, made fresh to order.',
      image: 'assets/images/chawarma.png',
      price: 2.49,
      available: false,
      increment: 10,
    ),
    const Bread(
      id: '4',
      name: 'Kesra',
      description:
          'Round and flat kesra bread, great for sandwiches or as a side.',
      image: 'assets/images/kesra.png',
      price: 1.49,
      available: true,
      increment: 10,
    ),
    const Bread(
      id: '5',
      name: 'Petit Pain',
      description: 'Small and fluffy bread, perfect for individual servings.',
      image: 'assets/images/petit_pain.png',
      price: 0.49,
      available: true,
      increment: 10,
    ),
    const Bread(
      id: '6',
      name: 'Pain Maison',
      description: 'Homemade bread, baked fresh every day.',
      image: 'assets/images/pain_maison.png',
      price: 3.99,
      available: true,
      increment: 10,
    ),
    const Bread(
      id: '7',
      name: 'Chapati',
      description:
          'Thin and chewy Indian bread, great for curries or as a wrap.',
      image: 'assets/images/chapati.png',
      price: 0.79,
      available: false,
      increment: 10,
    ),
  ];

  BreadCategoryPage({super.key});

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
          itemCount: breads.length,
          itemBuilder: (context, index) {
            return BreadCard(bread: breads[index]);
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
