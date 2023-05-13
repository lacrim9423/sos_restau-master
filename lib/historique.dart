import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class OrderHistoryPage extends StatelessWidget {
//   final String userId;

//   const OrderHistoryPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
//     final commandesRef = userRef.collection('commandes');

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Order History'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: commandesRef.orderBy('timestamp', descending: true).snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error loading order history: ${snapshot.error}'),
//             );
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           final commandes = snapshot.data!.docs;

//           if (commandes.isEmpty) {
//             return const Center(
//               child: Text('No order history found.'),
//             );
//           }

//           return ListView.builder(
//             itemCount: commandes.length,
//             itemBuilder: (BuildContext context, int index) {
//               final commande = commandes[index];
//               if (commande == null) {
//                 return const SizedBox.shrink();
//               }
//               final restaurant = commande['restaurant'];
//               final address = commande['adresse'];
//               final timestamp =
//                   DateTime.fromMillisecondsSinceEpoch(commande['timestamp']);
//               final items = commande['items'];

//               return Container(
//                 margin:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.grey,
//                       offset: Offset(0, 2),
//                       blurRadius: 5,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Restaurant: $restaurant',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'Address: $address',
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'Order date: ${DateFormat.yMMMd().add_jm().format(timestamp)}',
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                     const SizedBox(height: 10),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: items?.length ?? 0,
//                       itemBuilder: (BuildContext context, int index) {
//                         final item = items?[index];
//                         if (item == null) {
//                           return const SizedBox.shrink();
//                         }
//                         final name = item['name'];
//                         final quantity = item['quantity'];
//                         final price = item['price'];
//                         final total = item['total'];
//                         return Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('$name x $quantity'),
//                             Text('\$${total.toStringAsFixed(2)}'),
//                           ],
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   double _calculateTotal(List<Map<String, dynamic>> items) {
//     return items.fold(
//         0.0, (total, item) => total + (item['total'] as num).toDouble());
//   }
// }

class OrderHistoryPage extends StatelessWidget {
  final String userId;

  const OrderHistoryPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    final commandesRef = userRef.collection('commandes');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: commandesRef.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error loading order history: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final commandes = snapshot.data!.docs;

          if (commandes.isEmpty) {
            return const Center(
              child: Text('No order history found.'),
            );
          }

          return ListView.builder(
            itemCount: commandes.length,
            itemBuilder: (BuildContext context, int index) {
              final commande = commandes[index];
              if (commande == null) {
                return const SizedBox.shrink();
              }
              final restaurant = commande['restaurant'];
              final address = commande['adresse'];
              final timestamp =
                  DateTime.fromMillisecondsSinceEpoch(commande['timestamp']);
              final items = commande['items'];

              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Restaurant: $restaurant',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Address: $address',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Order date: ${DateFormat.yMMMd().add_jm().format(timestamp)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    ExpansionTile(
                      title: const Text('Items'),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final item = items?[index];
                            if (item == null) {
                              return const SizedBox.shrink();
                            }
                            final name = item['name'];
                            final quantity = item['quantity'];
                            final price = item['price'];
                            final total = item['total'];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('$name x $quantity'),
                                Text('\$${total.toStringAsFixed(2)}'),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}