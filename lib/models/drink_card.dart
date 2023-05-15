import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/class/drink.dart';

class DrinkCard extends StatefulWidget {
  final Drink drink;

  const DrinkCard({
    Key? key,
    required this.drink,
    required String title,
    required String imageUrl,
    required double price,
    required bool available,
    required String description,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DrinkCardState createState() => _DrinkCardState();
}

class _DrinkCardState extends State<DrinkCard> {
  int _quantity = 0;
  String? _selectedFlavor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              widget.drink.image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.drink.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Price: ${widget.drink.price}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              if (widget.drink.flavors.isNotEmpty) ...[
                DropdownButton<Flavor>(
                  value: _selectedFlavor != null
                      ? widget.drink.flavors.firstWhere(
                          (flavor) => flavor.id == _selectedFlavor!,
                          orElse: () => const Flavor(
                            id: '',
                            name: '',
                          ),
                        )
                      : null,
                  hint: const Text('Choisissez un parfum'),
                  items: widget.drink.flavors
                      .map((flavor) => DropdownMenuItem<Flavor>(
                            value: flavor,
                            child: Text(flavor.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedFlavor = value?.id;
                    });
                  },
                ),
              ],
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
                  final currentUser = FirebaseAuth.instance.currentUser;
                  final userId = currentUser != null ? currentUser.uid : '';

                  addItemToCart(
                    userId,
                    widget.drink,
                    _quantity,
                    _selectedFlavor ?? '',
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
                      widget.drink.available
                          ? Theme.of(context).primaryColor
                          : Colors.grey),
                ),
                child: Text(widget.drink.available
                    ? 'Ajouter au panier'
                    : 'Indisponible'),
              )
            ]),
          ),
        ],
      ),
    );
  }
}

Future<void> addItemToCart(
  String userId,
  Drink drink,
  int quantity,
  String selectedFlavor,
) async {
  if (quantity > 0) {
    try {
      final cartItemRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('panier')
          .doc(drink.name);
      final cartItem = await cartItemRef.get();

      if (cartItem.exists) {
        final int currentQuantity = cartItem.get('quantity');
        await cartItemRef.update({'quantity': currentQuantity + quantity});
      } else {
        await cartItemRef.set({
          'name': drink.name,
          'quantity': quantity,
          'price': drink.price,
          'image': drink.image,
          'flavor': selectedFlavor,
        });
      }

      if (kDebugMode) {
        print('Added $quantity ${drink.name} ($selectedFlavor) to cart.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding item to cart: $e');
      }
    }
  }
}
