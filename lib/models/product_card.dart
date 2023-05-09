import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/flash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/class/produit.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> addItemToCart(String userId, String productName, int quantity,
    double price, String image) async {
  if (quantity > 0) {
    try {
      final cartItemRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('panier')
          .doc(productName);
      final cartItem = await cartItemRef.get();

      if (cartItem.exists) {
        final int currentQuantity = cartItem.get('quantity');
        await cartItemRef.update({'quantity': currentQuantity + quantity});
      } else {
        await cartItemRef.set({
          'name': productName,
          'quantity': quantity,
          'price': price,
          'image': image,
        });
      }
      if (kDebugMode) {
        print('Added $quantity $productName to cart.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding item to cart: $e');
      }
    }
  }
}

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    Key? key,
    required this.product,
    required String description,
    required String title,
    required String imageUrl,
    required double price,
    required bool available,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
                    // Get the current user ID.
                    final currentUser = FirebaseAuth.instance.currentUser;
                    final userId = currentUser != null ? currentUser.uid : '';

                    // Call the addItemToCart function with the necessary arguments.
                    addItemToCart(
                      userId,
                      widget.product.name,
                      _quantity,
                      widget.product.price,
                      widget.product.image,
                    );

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
                          : Colors.grey,
                    ),
                  ),
                  child: Text(widget.product.available
                      ? 'Ajouter au panier'
                      : 'Indisponible'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
