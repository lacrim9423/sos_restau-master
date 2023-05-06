// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sos_restau/models/product_card.dart';
import 'package:sos_restau/class/produit.dart';

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
        title: const Text('Grocery Category'),
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
    );
  }
}
