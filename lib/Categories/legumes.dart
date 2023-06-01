// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/models/product_card.dart';
import 'package:sos_restau/class/produit.dart';
import 'package:sos_restau/historique.dart';
import 'package:sos_restau/home.dart';
import 'package:sos_restau/panier.dart';
import 'package:sos_restau/profile.dart';

class VegetablesCategoryPage extends StatefulWidget {
  const VegetablesCategoryPage({Key? key}) : super(key: key);

  @override
  _VegetablesCategoryPageState createState() => _VegetablesCategoryPageState();
}

class _VegetablesCategoryPageState extends State<VegetablesCategoryPage> {
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

  void _goToProfile(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
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

  final List<Product> _products = [
    Product(
      id: "1",
      name: 'Carotte',
      description: 'A nutritious root vegetable',
      price: 0.99,
      image: 'assets/images/legumes/carotte.jpg',
      available: true,
    ),
    Product(
      id: "2",
      name: 'ail',
      description: 'A healthy and delicious green vegetable',
      price: 2.49,
      image: 'assets/images/legumes/ail.jpg',
      available: true,
    ),
    Product(
      id: "3",
      name: 'aubergine',
      description: 'A versatile and nutritious vegetable',
      price: 3.99,
      image: 'assets/images/legumes/aubergine.jpg',
      available: true,
    ),
    Product(
      id: "4",
      name: 'tomate',
      description: 'A juicy and flavorful fruit-vegetable',
      price: 1.49,
      image: 'assets/images/legumes/tomate.jpg',
      available: true,
    ),
    Product(
      name: 'courgette',
      id: "5",
      description: 'A refreshing and hydrating vegetable',
      price: 0.99,
      image: 'assets/images/legumes/courgette.jpg',
      available: true,
    ),
    Product(
      id: "6",
      name: 'oignon',
      description: 'A versatile and flavorful vegetable',
      price: 1.99,
      image: 'assets/images/legumes/oignon.jpg',
      available: true,
    ),
    Product(
      id: "7",
      name: 'pomme de terre',
      description: 'A colorful and nutritious vegetable',
      price: 1.49,
      image: 'assets/images/legumes/pomme de terre.jpg',
      available: true,
    ),
    Product(
      id: "8",
      name: 'salade',
      description: 'A nutrient-rich and versatile leafy green',
      price: 2.99,
      image: 'assets/images/legumes/salade.jpg',
      available: true,
    ),
    Product(
      id: "9",
      name: 'artichaut',
      description: 'A nutrient-rich and versatile leafy green',
      price: 2.99,
      image: 'assets/images/legumes/artichaut.jpg',
      available: true,
    ),
    Product(
      id: "10",
      name: 'betterave',
      description: 'A nutrient-rich and versatile leafy green',
      price: 2.99,
      image: 'assets/images/legumes/betterave.jpg',
      available: true,
    ),
    Product(
      id: "11",
      name: 'brocoli',
      description: 'A nutrient-rich and versatile leafy green',
      price: 2.99,
      image: 'assets/images/legumes/brocoli.jpg',
      available: true,
    ),
    Product(
      id: "12",
      name: 'champignon',
      description: 'A nutrient-rich and versatile leafy green',
      price: 2.99,
      image: 'assets/images/legumes/champignon.jpg',
      available: true,
    ),
    Product(
      id: "13",
      name: 'chou',
      description: 'A nutrient-rich and versatile leafy green',
      price: 2.99,
      image: 'assets/images/legumes/chou.jpg',
      available: true,
    ),
    Product(
      id: "14",
      name: 'chou-fleur',
      description: 'A nutrient-rich and versatile leafy green',
      price: 2.99,
      image: 'assets/images/legumes/chou_fleur.jpg',
      available: true,
    ),
    Product(
      id: "15",
      name: 'courgette',
      description: 'A nutrient-rich and versatile leafy green',
      price: 2.99,
      image: 'assets/images/legumes/courgette.jpg',
      available: true,
    ),
    Product(
      id: "16",
      name: 'des épinards',
      description: 'A nutrient-rich and versatile leafy green',
      price: 2.99,
      image: 'assets/images/legumes/des_épinards.jpg',
      available: true,
    ),
    Product(
      id: "17",
      name: 'féves',
      description: 'A nutrient-rich and versatile leafy green',
      price: 2.99,
      image: 'assets/images/legumes/féves.jpg',
      available: true,
    ),
    Product(
      id: "18",
      name: 'haricot',
      description: 'A nutrient-rich and versatile leafy green',
      price: 2.99,
      image: 'assets/images/legumes/haricot.jpg',
      available: true,
    ),
    Product(
      id: "19",
      name: 'mais',
      description: 'A nutrient-rich and versatile leafy green',
      price: 2.99,
      image: 'assets/images/legumes/mais.jpg',
      available: true,
    ),
    Product(
      id: "20",
      name: 'melon',
      description: 'A nutrient-rich and versatile leafy green',
      price: 2.99,
      image: 'assets/images/legumes/melon.jpg',
      available: true,
    ),
    Product(
      id: "21",
      name: 'pimentrouge',
      description: 'A nutrient-rich and versatile leafy green',
      price: 2.99,
      image: 'assets/images/legumes/pimentrouge.jpg',
      available: true,
    ),
    Product(
      id: "22",
      name: 'poivron',
      description: 'A nutrient-rich and versatile leafy green',
      price: 2.99,
      image: 'assets/images/legumes/poivron.jpg',
      available: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';

    return Scaffold(
        appBar: AppBar(
          title: const Text('Légumes'),
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
