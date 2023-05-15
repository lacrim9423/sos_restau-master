// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
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
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void _goToProfile(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  Future<List<Drink>> fetchDrinksFromFirestore() async {
    final drinksCollection = FirebaseFirestore.instance.collection('drinks');
    final querySnapshot = await drinksCollection.get();

    final drinks = querySnapshot.docs.map((doc) {
      final data = doc.data();
      final flavors = (data['flavors'] as List)
          .map((flavor) => Flavor(
                id: flavor['id'],
                name: flavor['name'],
              ))
          .toList();

      return Drink(
        id: doc.id,
        name: data['name'],
        description: data['description'],
        price: data['price'],
        image: data['image'],
        available: data['available'],
        flavors: flavors,
      );
    }).toList();

    return drinks;
  }

  List<Drink> _drinks = [];

  @override
  void initState() {
    super.initState();
    fetchDrinksFromFirestore().then((drinks) {
      setState(() {
        _drinks = drinks;
      });
    }).catchError((error) {
      print('Failed to fetch drinks: $error');
    });
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
        itemCount: _drinks.length,
        itemBuilder: (BuildContext context, int index) {
          final drink = _drinks[index];
          return DrinkCard(
            key: ValueKey(drink.id),
            drink: drink,
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
                ;
              },
              icon: const Icon(Icons.person),
            ),
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
      ),
    );
  }
}
