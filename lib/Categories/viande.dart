import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/models/product_card.dart';
import '../class/produit.dart';
import 'package:sos_restau/historique.dart';
import 'package:sos_restau/home.dart';
import 'package:sos_restau/panier.dart';
import 'package:sos_restau/profile.dart';

class MeatCategoryPage extends StatelessWidget {
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
          builder: (context) => HomePage(
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

  final List<Product> meats = [
    Product(
      id: '1',
      name: 'Burger',
      description: 'Burger de boeuf grillé, garni de fromage et de légumes.',
      image: 'assets/images/burger.png',
      price: 4.99,
      available: true,
    ),
    Product(
      id: '2',
      name: 'Poulet',
      description: 'Poulet grillé, accompagné de riz et de légumes.',
      image: 'assets/images/chicken.png',
      price: 6.99,
      available: true,
    ),
    Product(
      id: '3',
      name: 'Cuisse de poulet',
      description: 'Cuisse de poulet grillée, accompagnée de frites.',
      image: 'assets/images/chicken_leg.png',
      price: 3.99,
      available: true,
    ),
    Product(
      id: '4',
      name: 'Escalope de poulet',
      description: 'Escalope de poulet panée, accompagnée de salade.',
      image: 'assets/images/chicken_schnitzel.png',
      price: 5.99,
      available: true,
    ),
    Product(
      id: '5',
      name: 'Nuggets',
      description: 'Nuggets de poulet croustillants, accompagnés de sauce.',
      image: 'assets/images/chicken_nuggets.png',
      price: 2.99,
      available: true,
    ),
    Product(
      id: '6',
      name: 'Escalope de dinde',
      description: 'Escalope de dinde grillée, accompagnée de légumes.',
      image: 'assets/images/turkey_schnitzel.png',
      price: 7.99,
      available: true,
    ),
  ];

  MeatCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';

    return Scaffold(
        appBar: AppBar(
          title: const Text('Viande'),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: meats.length,
          itemBuilder: (context, index) {
            final product = meats[index];
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
