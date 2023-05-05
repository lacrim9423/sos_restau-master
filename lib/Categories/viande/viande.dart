import 'package:flutter/material.dart';
import 'meat.dart';
import 'meat_card.dart';

class MeatCategoryPage extends StatelessWidget {
  final List<MeatProduct> meats = [
    const MeatProduct(
      id: '1',
      name: 'Burger',
      description: 'Burger de boeuf grillé, garni de fromage et de légumes.',
      image: 'assets/images/burger.png',
      price: 4.99,
      available: true,
    ),
    const MeatProduct(
      id: '2',
      name: 'Poulet',
      description: 'Poulet grillé, accompagné de riz et de légumes.',
      image: 'assets/images/chicken.png',
      price: 6.99,
      available: true,
    ),
    const MeatProduct(
      id: '3',
      name: 'Cuisse de poulet',
      description: 'Cuisse de poulet grillée, accompagnée de frites.',
      image: 'assets/images/chicken_leg.png',
      price: 3.99,
      available: true,
    ),
    const MeatProduct(
      id: '4',
      name: 'Escalope de poulet',
      description: 'Escalope de poulet panée, accompagnée de salade.',
      image: 'assets/images/chicken_schnitzel.png',
      price: 5.99,
      available: true,
    ),
    const MeatProduct(
      id: '5',
      name: 'Nuggets',
      description: 'Nuggets de poulet croustillants, accompagnés de sauce.',
      image: 'assets/images/chicken_nuggets.png',
      price: 2.99,
      available: true,
    ),
    const MeatProduct(
      id: '6',
      name: 'Escalope de dinde',
      description: 'Escalope de dinde grillée, accompagnée de légumes.',
      image: 'assets/images/turkey_schnitzel.png',
      price: 7.99,
      available: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Viande'),
      ),
      body: ListView.builder(
        itemCount: meats.length,
        itemBuilder: (context, index) {
          return MeatCard(
            meat: meats[index],
            onQuantityChanged: (quantity) {},
          );
        },
      ),
    );
  }
}
