import 'package:flutter/material.dart';
import 'package:sos_restau/Categories/Produits%20Laitiers/p_laitiers.dart';
import 'package:sos_restau/Categories/Produits%20Laitiers/p_laitiers_card.dart';

class DairyCategoryPage extends StatefulWidget {
  const DairyCategoryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DairyCategoryPageState createState() => _DairyCategoryPageState();
}

class _DairyCategoryPageState extends State<DairyCategoryPage> {
  int _quantity = 0;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits laitiers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _dairyProducts.length,
          itemBuilder: (context, index) {
            final dairyProduct = _dairyProducts[index];
            return DairyProductCard(
              product: dairyProduct,
            );
          },
        ),
      ),
    );
  }
}
