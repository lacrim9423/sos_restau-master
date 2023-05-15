import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/class/p_laitiers.dart';
import 'package:sos_restau/models/p_laitiers_card.dart';
import 'package:sos_restau/historique.dart';
import 'package:sos_restau/home.dart';
import 'package:sos_restau/panier.dart';
import 'package:sos_restau/profile.dart';

class DairyCategoryPage extends StatefulWidget {
  const DairyCategoryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DairyCategoryPageState createState() => _DairyCategoryPageState();
}

class _DairyCategoryPageState extends State<DairyCategoryPage> {
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

  // final List<DairyProduct> _dairyProducts = [
  //    const DairyProduct(
  //     id: '1',
  //     name: 'Lait écrémé',
  //     description: 'Lait demi-écrémé, idéal pour un petit déjeuner équilibré.',
  //     image: 'assets/images/milk.png',
  //     price: 0.99,
  //     available: true,
  //     units: ['L', 'ml'],
  //     isLiquid: true,
  //   ),
  //   const DairyProduct(
  //     id: '2',
  //     name: 'Fromage de chèvre',
  //     description: 'Fromage de chèvre frais, parfait pour vos salades.',
  //     image: 'assets/images/goat_cheese.png',
  //     price: 3.99,
  //     available: true,
  //     units: [Unit.gram, Unit.kilogram],
  //     isLiquid: false,
  //   ),
  //   const DairyProduct(
  //     id: '3',
  //     name: 'Sauce au fromage',
  //     description:
  //         'Sauce onctueuse à base de fromage, idéale pour vos plats de pâtes.',
  //     image: 'assets/images/cheese_sauce.png',
  //     price: 2.49,
  //     available: false,
  //     units: ['g', 'kg'],
  //     isLiquid: false,
  //   ),
  // ];
  final List<DairyProduct> _dairyProducts = [
    const DairyProduct(
      id: '1',
      name: 'Lait écrémé',
      description: 'Lait demi-écrémé, idéal pour un petit déjeuner équilibré.',
      image: 'assets/images/milk.png',
      price: 0.99,
      available: true,
      units: [Unit.liter, Unit.milliliter],
      isLiquid: true,
    ),
    const DairyProduct(
      id: '2',
      name: 'Fromage de chèvre',
      description: 'Fromage de chèvre frais, parfait pour vos salades.',
      image: 'assets/images/goat_cheese.png',
      price: 3.99,
      available: true,
      units: [Unit.gram, Unit.kilogram],
      isLiquid: false,
    ),
    const DairyProduct(
      id: '3',
      name: 'Sauce au fromage',
      description:
          'Sauce onctueuse à base de fromage, idéale pour vos plats de pâtes.',
      image: 'assets/images/cheese_sauce.png',
      price: 2.49,
      available: false,
      units: [Unit.gram, Unit.kilogram],
      isLiquid: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';

    return Scaffold(
        appBar: AppBar(
          title: const Text('Lait et Dérivés'),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: _dairyProducts.length,
          itemBuilder: (context, index) {
            final dairyProduct = _dairyProducts[index];
            return DairyProductCard(
              product: dairyProduct,
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
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Produits laitiers'),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: ListView.builder(
  //         itemCount: _dairyProducts.length,
  //         itemBuilder: (context, index) {
  //           final dairyProduct = _dairyProducts[index];
  //           return DairyProductCard(
  //             product: dairyProduct,
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
