import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final String userId;

  const CartPage({Key? key, required this.userId}) : super(key: key);

  void _incrementQuantity(String cartItemId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('panier')
        .doc(cartItemId)
        .update({'quantity': FieldValue.increment(1)});
  }

  void _decrementQuantity(String cartItemId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('panier')
        .doc(cartItemId)
        .update({'quantity': FieldValue.increment(-1)});
  }

  void _deleteCartItem(String cartItemId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('panier')
        .doc(cartItemId)
        .delete();
  }

  Future<void> validateCart(String userId) async {
  final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
  final userSnapshot = await userRef.get();
  final restaurantName = userSnapshot.get('restaurant');
  final restaurantAddress = userSnapshot.get('adresse');
  final userName = userSnapshot.get('nom');

  final cartItemsRef = userRef.collection('panier');
  final cartItems = await cartItemsRef.get();

  final commandesRef = userRef.collection('commandes');
  final facturesRef = userRef.collection('factures');

  final batch = FirebaseFirestore.instance.batch();

  for (final cartItem in cartItems.docs) {
    final name = cartItem.get('name');
    final price = cartItem.get('price');
    final quantity = cartItem.get('quantity');

    final commandeData = {
      'name': name,
      'price': price,
      'quantity': quantity,
      'restaurantName': restaurantName,
      'restaurantAddress': restaurantAddress,
      'userName': userName,
    };
    batch.set(commandesRef.doc(name), commandeData);

    final factureData = {
      'name': name,
      'price': price,
      'quantity': quantity,
      'userName': userName,
      'restaurantName': restaurantName,
    };
    batch.set(facturesRef.doc(name), factureData);

    batch.delete(cartItemsRef.doc(name));
  }

  try {
    await batch.commit();
    if (kDebugMode) {
      print('Cart validated successfully.');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error validating cart: $e');
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('panier')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final cartItems = snapshot.data!.docs;

          if (cartItems.isEmpty) {
            return const Center(
              child: Text('Your cart is empty'),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartItem['name'],
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  'Price: ${cartItem['price']}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        _decrementQuantity(cartItem.id);
                                      },
                                      child: const Text('-'),
                                    ),
                                    Text('${cartItem['quantity']}'),
                                    TextButton(
                                      onPressed: () {
                                        _incrementQuantity(cartItem.id);
                                      },
                                      child: const Text('+'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                _deleteCartItem(cartItem.id);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Total price:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final userData =
                            snapshot.data!.data() as Map<String, dynamic>;
                        final totalPrice = userData['total_price'];

                        return Text(
                          '\$$totalPrice',
                          style: Theme.of(context).textTheme.titleLarge,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        validateCart(userId);
                      },
                      child: const Text('Validate Cart'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
