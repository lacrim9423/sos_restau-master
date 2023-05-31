// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/historique.dart';
import 'package:sos_restau/home.dart';
import 'package:sos_restau/profile.dart';

class CartPage extends StatefulWidget {
  final String userId;

  const CartPage({Key? key, required this.userId}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    totalPrice = 0.0;
  }

  void _goToHome(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const HomePage(
                userId: '',
              )),
    );
  }

  void _goToPanier(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage(userId: userId)),
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

  void _incrementQuantity(String cartItemId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('panier')
        .doc(cartItemId)
        .update({'quantity': FieldValue.increment(1)}).then((_) => setState(() {
              totalPrice += 1; // Update total price
            }));
  }

  void _decrementQuantity(String cartItemId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('panier')
        .doc(cartItemId)
        .update({'quantity': FieldValue.increment(-1)}).then(
            (_) => setState(() {
                  totalPrice -= 1; // Update total price
                }));
  }

  void _deleteCartItem(String cartItemId, double itemPrice, int itemQuantity) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('panier')
        .doc(cartItemId)
        .delete()
        .then((_) => setState(() {
              totalPrice -= itemPrice * itemQuantity; // Update total price
            }));
  }

  Future<void> validateCart(String userId, bool isTomorrow, bool isWeek,
      bool isMonth, BuildContext context) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    final cartItems = await userRef.collection('panier').get();

    if (cartItems.docs.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Empty Cart'),
            content: const Text('Your cart is empty.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Stop further execution if the cart is empty
    }
    final commandesRef = userRef.collection('commandes').doc();
    final facturesRef = userRef.collection('factures').doc();

    final validatedCart = cartItems.docs.map((cartItem) {
      final productName = cartItem.get('name');
      final quantity = cartItem.get('quantity');
      final price = cartItem.get('price');
      final total = quantity * price;

      return {
        'name': productName,
        'quantity': quantity,
        'price': price,
        'total': total,
      };
    }).toList();

    final user = await userRef.get();
    final restaurantName = user.get('restaurant');
    final address = user.get('adresse');
    final userName = user.get('nom');
    final timestamp = DateTime.now().toUtc().millisecondsSinceEpoch;

    await commandesRef.set({
      'restaurant': restaurantName,
      'adresse': address,
      'nom': userName,
      'timestamp': timestamp,
      'isTomorrow': isTomorrow,
      'isWeek': isWeek,
      'isMonth': isMonth,
      'totalPrice': totalPrice, // Include the totalPrice
      'items': validatedCart,
    });

    await facturesRef.set({
      'nom': userName,
      'restaurant': restaurantName,
      'timestamp': timestamp,
      'isTomorrow': isTomorrow,
      'isWeek': isWeek,
      'isMonth': isMonth,
      'items': validatedCart,
      'totalPrice': totalPrice, // Include the totalPrice

      'paid': false,
    });

    final batch = FirebaseFirestore.instance.batch();

    for (final cartItem in cartItems.docs) {
      batch.delete(cartItem.reference);
    }

    await batch.commit();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Your order has been validated.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showOrderDurationDialog(BuildContext context) async {
    String? selectedDuration;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Order Duration'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  selectedDuration = 'tomorrow';
                  Navigator.pop(context);
                },
                child: const Text('Order for Tomorrow'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  selectedDuration = 'week';
                  Navigator.pop(context);
                },
                child: const Text('Order for Next 7 Days'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  selectedDuration = 'month';
                  Navigator.pop(context);
                },
                child: const Text('Order for Next 30 Days'),
              ),
            ],
          ),
        );
      },
    );

    // Handle the selected duration
    if (selectedDuration != null) {
      // Perform the necessary actions based on the selected duration
      bool isTomorrow = selectedDuration == 'tomorrow';
      bool isWeek = selectedDuration == 'week';
      bool isMonth = selectedDuration == 'month';

      // Call the validateCart function with the selected duration
      await validateCart(widget.userId, isTomorrow, isWeek, isMonth, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .collection('panier')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final cartItems = snapshot.data!.docs;
          if (cartItems.isEmpty) {
            return const Center(
              child: Text('Your cart is empty.'),
            );
          }

          return ListView.builder(
            itemCount: cartItems.length,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              final cartItemId = cartItem.id;
              final productName = cartItem.get('name');
              final productPrice = cartItem.get('price');
              final productQuantity = cartItem.get('quantity');
              final imageUrl = cartItem.get('image');

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  title: Text(productName),
                  subtitle: Text('Price: \$${productPrice.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          _decrementQuantity(cartItemId);
                        },
                        icon: const Icon(Icons.remove, color: Colors.black),
                      ),
                      Text(productQuantity.toString()),
                      IconButton(
                        onPressed: () {
                          _incrementQuantity(cartItemId);
                        },
                        icon: const Icon(Icons.add, color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {
                          _deleteCartItem(
                              cartItemId, productPrice, productQuantity);
                        },
                        icon: const Icon(Icons.delete, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showOrderDurationDialog(context);
        },
        label: const Text('Valider Le Panier'),
        icon: const Icon(Icons.check),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
