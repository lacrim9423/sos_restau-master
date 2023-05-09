// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class CartPage extends StatelessWidget {
//   final String userId;

//   const CartPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cart'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(userId)
//             .collection('panier')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           final cartItems = snapshot.data!.docs;

//           if (cartItems.isEmpty) {
//             return const Center(
//               child: Text('Your cart is empty'),
//             );
//           }

//           return ListView.builder(
//             itemCount: cartItems.length,
//             itemBuilder: (context, index) {
//               final cartItem = cartItems[index];

//               return ListTile(
//                 title: Text(cartItem['name']),
//                 subtitle:
//                     Text('${cartItem['quantity']} x ${cartItem['price']}'),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// // class CartPage extends StatelessWidget {
// //   const CartPage({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     final cart = Provider.of<Cart>(context);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Cart'),
// //       ),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: cart.items.length,
// //               itemBuilder: (context, index) {
// //                 final cartItem = cart.items[index];

// //                 return ListTile(
// //                   title: Text(cartItem.name),
// //                   subtitle: Text('\$${cartItem.price.toStringAsFixed(2)}'),
// //                   trailing: SizedBox(
// //                     width: 96,
// //                     child: Row(
// //                       children: [
// //                         IconButton(
// //                           onPressed: () => cart.addItem(cartItem),
// //                           icon: const Icon(Icons.add),
// //                         ),
// //                         Text(cartItem.quantity.toString()),
// //                         IconButton(
// //                           onPressed: () => cart.removeItem(cartItem.ref),
// //                           icon: const Icon(Icons.remove),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //           const SizedBox(height: 16),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.end,
// //             children: [
// //               Text(
// //                 'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
// //                 style: Theme.of(context).textTheme.subtitle1,
// //               ),
// //               const SizedBox(width: 16),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   // TODO: Implement cart validation logic
// //                 },
// //                 child: const Text('Validate Cart'),
// //               ),
// //               const SizedBox(width: 16),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final String userId;

  const CartPage({Key? key, required this.userId}) : super(key: key);

  @override
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

  void _validateCart() {
    // TODO: Implement the cart validation logic
  }

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
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  'Price: ${cartItem['price']}',
                                  style: Theme.of(context).textTheme.caption,
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
                      style: Theme.of(context).textTheme.subtitle1,
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
                          style: Theme.of(context).textTheme.headline6,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _validateCart();
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
