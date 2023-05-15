// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/class/drink.dart';
import 'package:sos_restau/models/drink_card.dart';
import 'package:sos_restau/historique.dart';
import 'package:sos_restau/home.dart';
import 'package:sos_restau/panier.dart';
import 'package:sos_restau/profile.dart';

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
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  void _goToProfile(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  final List<Drink> _drinks = [
    const Drink(
      id: '1',
      name: 'Fanta',
      description: 'Boisson gazeuse au goût d\'orange',
      price: 2.49,
      image: 'assets/images/fanta.jpg',
      available: true,
      flavors: [
        Flavor(id: '1', name: 'Orange'),
        Flavor(id: '2', name: 'Fraise'),
        Flavor(id: '3', name: 'Pomme'),
        Flavor(id: '4', name: 'Citron'),
      ],
    ),
    const Drink(
      id: '2',
      name: 'Coca-Cola',
      description: 'Boisson gazeuse au goût de cola',
      price: 1.99,
      image: 'assets/images/coca_cola.jpg',
      available: false,
      flavors: [
        Flavor(id: '5', name: 'Classique'),
        Flavor(id: '6', name: 'Zéro'),
        Flavor(id: '7', name: 'Light'),
      ],
    ),
    const Drink(
      id: '3',
      name: 'Sprite',
      description: 'Boisson gazeuse au goût de citron vert',
      price: 2.29,
      image: 'assets/images/sprite.jpg',
      available: true,
      flavors: [
        Flavor(id: '8', name: 'Citron vert'),
        Flavor(id: '9', name: 'Fruit punch'),
        Flavor(id: '10', name: 'Mélange de baies'),
      ],
    ),
    const Drink(
      id: '4',
      name: 'Thé glacé',
      description: 'Boisson rafraîchissante au thé',
      price: 3.49,
      image: 'assets/images/the_glace.jpg',
      available: true,
      flavors: [
        Flavor(id: '11', name: 'Pêche'),
        Flavor(id: '12', name: 'Citron'),
        Flavor(id: '13', name: 'Framboise'),
      ],
    ),
    const Drink(
      id: '5',
      name: 'Jus de pomme',
      description: 'Jus de pomme pressé',
      price: 2.99,
      image: 'assets/images/jus_pomme.jpg',
      available: true,
      flavors: [],
    ),
    const Drink(
      id: '6',
      name: 'Eau minérale',
      description: 'Eau de source naturelle',
      price: 1.49,
      image: 'assets/images/eau_minerale.jpg',
      available: true,
      flavors: [],
    ),
  ];

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
          itemCount: _drinks.length,
          itemBuilder: (BuildContext context, int index) {
            return DrinkCard(
              key: ValueKey(_drinks[index].id),
              drink: _drinks[index],
              title: _drinks[index].name,
              description: _drinks[index].description,
              imageUrl: _drinks[index].image,
              price: _drinks[index].price,
              available: _drinks[index].available,
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
