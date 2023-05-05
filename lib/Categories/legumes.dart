// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sos_restau/product_card.dart';
import 'package:sos_restau/produit.dart';

class VegetablesCategoryPage extends StatefulWidget {
  const VegetablesCategoryPage({Key? key}) : super(key: key);

  @override
  _VegetablesCategoryPageState createState() => _VegetablesCategoryPageState();
}

class _VegetablesCategoryPageState extends State<VegetablesCategoryPage> {
  final List<Product> _products = [
    Product(
      name: 'Carrot',
      description: 'A nutritious root vegetable',
      price: 0.99,
      image: 'assets/images/carrot.jpg',
      available: true,
    ),
    Product(
      name: 'Broccoli',
      description: 'A healthy and delicious green vegetable',
      price: 2.49,
      image: 'assets/images/broccoli.jpg',
      available: true,
    ),
    Product(
      name: 'Cauliflower',
      description: 'A versatile and nutritious vegetable',
      price: 3.99,
      image: 'assets/images/cauliflower.jpg',
      available: true,
    ),
    Product(
      name: 'Tomato',
      description: 'A juicy and flavorful fruit-vegetable',
      price: 1.49,
      image: 'assets/images/tomato.jpg',
      available: true,
    ),
    Product(
      name: 'Cucumber',
      description: 'A refreshing and hydrating vegetable',
      price: 0.99,
      image: 'assets/images/cucumber.jpg',
      available: true,
    ),
    Product(
      name: 'Eggplant',
      description: 'A versatile and flavorful vegetable',
      price: 1.99,
      image: 'assets/images/eggplant.jpg',
      available: true,
    ),
    Product(
      name: 'Bell Pepper',
      description: 'A colorful and nutritious vegetable',
      price: 1.49,
      image: 'assets/images/bell_pepper.jpg',
      available: true,
    ),
    Product(
      name: 'Spinach',
      description: 'A nutrient-rich and versatile leafy green',
      price: 2.99,
      image: 'assets/images/spinach.jpg',
      available: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vegetables'),
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
