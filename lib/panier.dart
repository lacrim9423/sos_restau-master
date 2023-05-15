// // ignore_for_file: use_build_context_synchronously

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:sos_restau/historique.dart';
// import 'package:sos_restau/home.dart';
// import 'package:sos_restau/profile.dart';

// class CartPage extends StatelessWidget {
//   final String userId;

//   const CartPage({Key? key, required this.userId}) : super(key: key);
//   void _goToPanier(BuildContext context, String userId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CartPage(userId: userId)),
//     );
//   }

//   void _goToHome(BuildContext context, String userId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const HomePage()),
//     );
//   }

//   void _goToCommandes(BuildContext context, String userId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => OrderHistoryPage(userId: userId)),
//     );
//   }

//   void _goToProfile(BuildContext context, String userId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const ProfilePage()),
//     );
//   }

//   void _incrementQuantity(String cartItemId) {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(userId)
//         .collection('panier')
//         .doc(cartItemId)
//         .update({'quantity': FieldValue.increment(1)});
//   }

//   void _decrementQuantity(String cartItemId) {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(userId)
//         .collection('panier')
//         .doc(cartItemId)
//         .update({'quantity': FieldValue.increment(-1)});
//   }

//   void _deleteCartItem(String cartItemId) {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(userId)
//         .collection('panier')
//         .doc(cartItemId)
//         .delete();
//   }

//   Future<void> validateCart(String userId, bool isTomorrow, bool isWeek,
//       bool isMonth, BuildContext context) async {
//     final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
//     final cartItems = await userRef.collection('panier').get();

//     if (cartItems.docs.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Empty Cart'),
//             content: const Text('Your cart is empty.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//       return; // Stop further execution if the cart is empty
//     }
//     final commandesRef = userRef.collection('commandes').doc();
//     final facturesRef = userRef.collection('factures').doc();

//     final validatedCart = cartItems.docs.map((cartItem) {
//       final productName = cartItem.get('name');
//       final quantity = cartItem.get('quantity');
//       final price = cartItem.get('price');
//       final total = quantity * price;

//       return {
//         'name': productName,
//         'quantity': quantity,
//         'price': price,
//         'total': total,
//       };
//     }).toList();

//     final user = await userRef.get();
//     final restaurantName = user.get('restaurant');
//     final address = user.get('adresse');
//     final userName = user.get('nom');
//     final timestamp = DateTime.now().toUtc().millisecondsSinceEpoch;

//     await commandesRef.set({
//       'restaurant': restaurantName,
//       'adresse': address,
//       'nom': userName,
//       'timestamp': timestamp,
//       'isTomorrow': isTomorrow,
//       'isWeek': isWeek,
//       'isMonth': isMonth,
//       'items': validatedCart,
//     });

//     await facturesRef.set({
//       'nom': userName,
//       'restaurant': restaurantName,
//       'timestamp': timestamp,
//       'isTomorrow': isTomorrow,
//       'isWeek': isWeek,
//       'isMonth': isMonth,
//       'items': validatedCart,
//       'paid': false,
//     });

//     final batch = FirebaseFirestore.instance.batch();

//     for (final cartItem in cartItems.docs) {
//       batch.delete(cartItem.reference);
//     }
//     // await generateInvoice(userId);

//     await batch.commit();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Success'),
//           content: const Text('Your order has been validated.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> showOrderDurationDialog(BuildContext context) async {
//     String? selectedDuration;

//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select Order Duration'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   selectedDuration = 'tomorrow';
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Order for Tomorrow'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   selectedDuration = 'week';
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Order for Next 7 Days'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   selectedDuration = 'month';
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Order for Next 30 Days'),
//               ),
//             ],
//           ),
//         );
//       },
//     );

//     // Handle the selected duration
//     if (selectedDuration != null) {
//       // Perform the necessary actions based on the selected duration
//       bool isTomorrow = selectedDuration == 'tomorrow';
//       bool isWeek = selectedDuration == 'week';
//       bool isMonth = selectedDuration == 'month';

//       // Call the validateCart function with the selected duration
//       await validateCart(userId, isTomorrow, isWeek, isMonth, context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Cart'),
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('users')
//               .doc(userId)
//               .collection('panier')
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             }

//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }

//             final cartItems = snapshot.data!.docs;

//             if (cartItems.isEmpty) {
//               return const Center(
//                 child: Text('Your cart is empty'),
//               );
//             }

//             return Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: cartItems.length,
//                     itemBuilder: (context, index) {
//                       final cartItem = cartItems[index];

//                       return Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     cartItem['name'],
//                                     style:
//                                         Theme.of(context).textTheme.titleMedium,
//                                   ),
//                                   Text(
//                                     'Price: ${cartItem['price']}',
//                                     style:
//                                         Theme.of(context).textTheme.bodySmall,
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Row(
//                                     children: [
//                                       TextButton(
//                                         onPressed: () {
//                                           _decrementQuantity(cartItem.id);
//                                         },
//                                         child: const Text('-'),
//                                       ),
//                                       Text('${cartItem['quantity']}'),
//                                       TextButton(
//                                         onPressed: () {
//                                           _incrementQuantity(cartItem.id);
//                                         },
//                                         child: const Text('+'),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   _deleteCartItem(cartItem.id);
//                                 },
//                                 icon: const Icon(Icons.delete),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'Total price:',
//                         style: Theme.of(context).textTheme.titleMedium,
//                       ),
//                       const SizedBox(height: 8),
//                       StreamBuilder<DocumentSnapshot>(
//                         stream: FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(userId)
//                             .snapshots(),
//                         builder: (context, snapshot) {
//                           if (!snapshot.hasData) {
//                             return const Center(
//                                 child: CircularProgressIndicator());
//                           }

//                           final userData =
//                               snapshot.data!.data() as Map<String, dynamic>;
//                           final totalPrice = userData['total_price'];

// ignore_for_file: use_build_context_synchronously

//                           return Text(
//                             '\$$totalPrice',
//                             style: Theme.of(context).textTheme.titleLarge,
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: () {
//                           showOrderDurationDialog;
//                         },
//                         child: const Text('Validate Cart'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//         bottomNavigationBar: BottomAppBar(
//           color: Colors.orange.shade50,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   _goToHome;
//                 },
//                 icon: const Icon(Icons.home),
//               ),
//               IconButton(
//                 onPressed: () {
//                   _goToPanier(context, userId);
//                 },
//                 icon: const Icon(Icons.shopping_cart),
//               ),
//               IconButton(
//                 onPressed: () {
//                   _goToCommandes(context, userId);
//                 },
//                 icon: const Icon(Icons.history),
//               ),
//               IconButton(
//                 onPressed: () {
//                   _goToProfile(context, userId);
//                 },
//                 icon: const Icon(Icons.person),
//               ),
//             ],
//           ),
//         ));
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/historique.dart';
import 'package:sos_restau/home.dart';
import 'package:sos_restau/profile.dart';

class CartPage extends StatelessWidget {
  final String userId;

  const CartPage({Key? key, required this.userId}) : super(key: key);
  void _goToPanier(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage(userId: userId)),
    );
  }

  void _goToHome(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
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
      'paid': false,
    });

    final batch = FirebaseFirestore.instance.batch();

    for (final cartItem in cartItems.docs) {
      batch.delete(cartItem.reference);
    }
    // await generateInvoice(userId);

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
              ElevatedButton(
                onPressed: () {
                  selectedDuration = 'week';
                  Navigator.pop(context);
                },
                child: const Text('Order for Next 7 Days'),
              ),
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
      await validateCart(userId, isTomorrow, isWeek, isMonth, context);
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
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  'Price: ${cartItem['price']}',
                                  style: Theme.of(context).textTheme.titleSmall,
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
                      style: Theme.of(context).textTheme.titleLarge,
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
                            child: CircularProgressIndicator(),
                          );
                        }

                        final userData =
                            snapshot.data!.data() as Map<String, dynamic>;
                        final totalPrice = userData['total_price'];

                        return Text(
                          '\$$totalPrice',
                          style: Theme.of(context).textTheme.headlineSmall,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        showOrderDurationDialog(context);
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange.shade50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                _goToHome(context, userId);
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                _goToPanier(context, userId);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            IconButton(
              onPressed: () {
                _goToCommandes(context, userId);
              },
              icon: const Icon(Icons.history),
            ),
            IconButton(
              onPressed: () {
                _goToProfile(context, userId);
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
