import 'package:flutter/material.dart';
import 'package:sos_restau/Categories/pain/pain.dart';
import 'package:sos_restau/Categories/pain/pain_card.dart';

class BreadCategoryPage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breads'),
      ),
      body: ListView.builder(
        itemCount: breads.length,
        itemBuilder: (context, index) {
          return BreadCard(bread: breads[index]);
        },
      ),
    );
  }
}
