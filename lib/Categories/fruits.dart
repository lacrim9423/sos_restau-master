// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sos_restau/product_card.dart';
import 'package:sos_restau/produit.dart';

class FruitCategoryPage extends StatefulWidget {
  const FruitCategoryPage({Key? key}) : super(key: key);

  @override
  _FruitCategoryPageState createState() => _FruitCategoryPageState();
}

class _FruitCategoryPageState extends State<FruitCategoryPage> {
  final List<Product> _products = [
    Product(
      name: 'Apple',
      description: 'A juicy and delicious fruit',
      price: 1.99,
      image: 'assets/images/apple.jpg',
      available: true,
    ),
    Product(
      name: 'Banana',
      description: 'A sweet and nutritious fruit',
      price: 0.99,
      image: 'assets/images/banana.jpg',
      available: false,
    ),
    Product(
      name: 'Orange',
      description: 'A tangy and refreshing fruit',
      price: 2.49,
      image: 'assets/images/orange.jpg',
      available: true,
    ),
    Product(
      name: 'Strawberry',
      description: 'A small and tasty fruit',
      price: 3.99,
      image: 'assets/images/strawberry.jpg',
      available: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(
            product: _products[index],
            title: _products[index].name,
            description: _products[index].description,
            imageUrl: _products[index].image,
            price: _products[index].price,
            available: _products[index].available,
          );
        },
      ),
    );
  }
}
