// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sos_restau/produit.dart';
import 'package:flash/flash.dart';

class GroceryCategoryPage extends StatefulWidget {
  const GroceryCategoryPage({Key? key}) : super(key: key);

  @override
  _GroceryCategoryPageState createState() => _GroceryCategoryPageState();
}

class _GroceryCategoryPageState extends State<GroceryCategoryPage> {
  List<Product> groceryProducts = [
    Product(
      name: 'Pasta',
      image: 'assets/images/pasta.jpg',
      price: 2.99,
      available: true,
      description: '',
    ),
    Product(
      name: 'Rice',
      image: 'assets/images/rice.jpg',
      price: 1.99,
      available: true,
      description: '',
    ),
    Product(
      name: 'Cereal',
      image: 'assets/images/cereal.jpg',
      price: 3.49,
      available: false,
      description: '',
    ),
    Product(
      name: 'Bread',
      image: 'assets/images/bread.jpg',
      price: 1.49,
      available: true,
      description: '',
    ),
    Product(
      name: 'Milk',
      image: 'assets/images/milk.jpg',
      price: 2.99,
      available: true,
      description: '',
    ),
    Product(
      name: 'Cheese',
      image: 'assets/images/cheese.jpg',
      price: 4.99,
      available: true,
      description: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Épicerie'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: groceryProducts.length,
        itemBuilder: (context, index) {
          final product = groceryProducts[index];
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

class ProductCard extends StatefulWidget {
  final Product product;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final bool available;

  const ProductCard({
    Key? key,
    required this.product,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.available,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              widget.product.image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Price: ${widget.product.price}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Quantity:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _quantity = _quantity > 0 ? _quantity - 1 : 0;
                            });
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(
                          '$_quantity',
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _quantity += 1;
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    showFlash(
                      context: context,
                      duration: const Duration(seconds: 2),
                      builder: (_, controller) {
                        return Flash(
                          controller: controller,
                          behavior: FlashBehavior.floating,
                          position: FlashPosition.bottom,
                          margin: const EdgeInsets.all(16),
                          borderRadius: BorderRadius.circular(8),
                          backgroundColor: Colors.grey[900]!,
                          child: const DefaultTextStyle(
                            style: TextStyle(color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text('Produit ajouté au panier!'),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        widget.product.available
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                  ),
                  child: Text(widget.product.available
                      ? 'Ajouter au panier'
                      : 'Indisponible'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
