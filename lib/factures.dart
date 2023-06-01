// ignore_for_file: deprecated_member_use

//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//import 'package:sos_restau/home.dart';
//import 'package:sos_restau/profile.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'package:sos_restau/historique.dart';
//import 'package:sos_restau/panier.dart';

//class Invoice {
//final double total;
//final bool paid;
//final List<Map<String, dynamic>> items;

// Invoice({
// required this.total,
//required this.paid,
//required this.items,
// });
//}

//class InvoicePage extends StatelessWidget {
//final String userId;

//const InvoicePage({Key? key, required this.userId}) : super(key: key);
//void _goToPanier(BuildContext context, String userId) {
//Navigator.push(
//context,
//MaterialPageRoute(builder: (context) => CartPage(userId: userId)),
//);
// }

//void _goToHome(BuildContext context, String userId) {
//Navigator.push(
//context,
//MaterialPageRoute(builder: (context) => HomePage()),
//);
// }

//void _goToCommandes(BuildContext context, String userId) {
//Navigator.push(
//context,
//MaterialPageRoute(builder: (context) => OrderHistoryPage(userId: userId)),
//);
//}

//void _goToProfile(BuildContext context, String userId) {
//Navigator.push(
//context,
//MaterialPageRoute(builder: (context) => const ProfilePage()),
//);
//}

//Future<String> _getInvoiceUrl(String invoiceId) async {
// final downloadURL = await firebase_storage.FirebaseStorage.instance
//  .ref('factures/$invoiceId.pdf')
//.getDownloadURL();
//return downloadURL;
// }

//@override
//Widget build(BuildContext context) {
//final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
//final facturesRef = userRef.collection('factures');

//return Scaffold(
//  appBar: AppBar(
//  title: const Text('Factures'),
//),
//body: StreamBuilder<QuerySnapshot>(
//stream:
//  facturesRef.orderBy('timestamp', descending: true).snapshots(),
//builder: (context, snapshot) {
//if (snapshot.hasError) {
//return Center(
//child: Text('Error loading invoices: ${snapshot.error}'),
//);
//}

//if (snapshot.connectionState == ConnectionState.waiting) {
//return const Center(
//child: CircularProgressIndicator(),
//);
//}

//final documents = snapshot.data!.docs;

//      if (documents.isEmpty) {
//      return const Center(
//      child: Text("Vous n'avez pas de factures."),
//  );
//  }

//final invoices = documents.map((document) {
//final items = List<Map<String, dynamic>>.from(document['items']);
//    final total = 1.0;
//  final paid = document['paid'];
//return Invoice(total: total, paid: paid, items: items);
//       }).toList();
//     return ListView.builder(
//     itemCount: invoices.length,
//   itemBuilder: (context, index) {
//   final invoice = invoices[index];
// final document = documents[index];

//                return Container(
//                margin:
//                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//            padding: const EdgeInsets.all(10),
//          decoration: BoxDecoration(
//          color: Colors.white,
//        borderRadius: BorderRadius.circular(20),
//      boxShadow: const [
//      BoxShadow(
//      color: Colors.grey,
//    offset: Offset(0, 2),
//  blurRadius: 5,
//   ),
// ],
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//         Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//       Text(
//       'Total: \$${invoice.total.toStringAsFixed(2)}',
//     style: const TextStyle(
//     fontSize: 16,
//   fontWeight: FontWeight.bold,
//),
// ),
// Text(
//                     invoice.paid ? 'Paid' : 'Not paid',
//                   style: TextStyle(
//                   fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               color: invoice.paid ? Colors.green : Colors.red,
//           ),
//       ),
//   ],
//                    ),
//                  const SizedBox(height: 10),
//                ElevatedButton(
//                onPressed: () async {
//                String invoiceUrl = await _getInvoiceUrl(document
//                  .id); // Pass the invoice ID to retrieve the correct URL
//            if (await canLaunch(invoiceUrl)) {
//            await launch(invoiceUrl);
//        } else {
//        throw 'Could not launch $invoiceUrl';
//    }
//                    },
//                  child: const Text('Facture'),
//              ),
//          ],
//      ),
//  );
//              },
//          );
//      },
//  ),
//     bottomNavigationBar: BottomAppBar(
//     color: Colors.black,
//   child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//         IconButton(
//         onPressed: () {
//         _goToHome;
//     },
//   icon: const Icon(Icons.home, color: Colors.white),
// ),
//           IconButton(
//           onPressed: () {
//           _goToPanier(context, userId);
//       },
//     icon: const Icon(Icons.shopping_cart, color: Colors.white),
//             ),
//           IconButton(
//           onPressed: () {
//           _goToCommandes(context, userId);
//              },
//            icon: const Icon(Icons.history, color: Colors.white),
//        ),
//      IconButton(
//       onPressed: () {
//                _goToProfile(context, userId);
//            },
//          icon: const Icon(Icons.person, color: Colors.white),
//      ),
//  ],
//          ),
//      ));
// }
//}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InvoicePage extends StatefulWidget {
  final String userId;

  const InvoicePage({Key? key, required this.userId}) : super(key: key);

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .collection('factures')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final invoices = snapshot.data!.docs;
          if (invoices.isEmpty) {
            return const Center(
              child: Text('No invoices found.'),
            );
          }

          return ListView.builder(
            itemCount: invoices.length,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              final invoice = invoices[index];
              final invoiceId = invoice.id;
              final restaurantName = invoice.get('restaurant');
              final timestamp = invoice.get('timestamp');
              final isTomorrow = invoice.get('isTomorrow');
              final isWeek = invoice.get('isWeek');
              final isMonth = invoice.get('isMonth');
              final items = invoice.get('items');
              final totalPrice = invoice.get('totalPrice');
              final paid = invoice.get('paid');

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text('Invoice #$invoiceId'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Restaurant: $restaurantName'),
                      Text('Timestamp: $timestamp'),
                      Text('Is Tomorrow: $isTomorrow'),
                      Text('Is Week: $isWeek'),
                      Text('Is Month: $isMonth'),
                      Text('Total Price: $totalPrice'),
                      Text('Paid: $paid'),
                      const SizedBox(height: 8),
                      const Text('Items:'),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final itemName = item['name'];
                          final itemQuantity = item['quantity'];
                          final itemPrice = item['price'];
                          final itemTotal = item['total'];

                          return ListTile(
                            title: Text('$itemName x $itemQuantity'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Price: $itemPrice'),
                                Text('Total: $itemTotal'),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InvoicePage(userId: 'your_user_id'),
    );
  }
}
