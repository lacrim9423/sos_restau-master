// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sos_restau/historique.dart';
import 'package:sos_restau/facture_view.dart';
import 'package:sos_restau/panier.dart';
import 'package:sos_restau/profile.dart';

import 'home.dart';

class InvoicePage extends StatefulWidget {
  final String userId;

  const InvoicePage({Key? key, required this.userId}) : super(key: key);

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

void _goToHome(BuildContext context, String userId) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const HomePage(
        userId: '',
      ),
    ),
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

class _InvoicePageState extends State<InvoicePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';
    return Scaffold(
        appBar: AppBar(
          title: const Text('Factures'),
          centerTitle: true,
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
                child: Text('Aucune facture trouvée.'),
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
                final formattedDate = DateFormat('yyyy-MM-dd')
                    .format(DateTime.fromMillisecondsSinceEpoch(timestamp));
                final isPaid = invoice.get('paid');

                return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListTile(
                      title: Text('Facture #$invoiceId'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Restaurant: $restaurantName'),
                          Text('Date: $formattedDate'),
                          Text('Total: ${invoice.get('totalPrice')}'),
                          Row(
                            children: [
                              Icon(
                                isPaid ? Icons.check : Icons.close,
                                color: isPaid ? Colors.green : Colors.red,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                isPaid ? 'Payé' : 'Non payé',
                                style: TextStyle(
                                  color: isPaid ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                InvoiceDetailsPage(invoice: invoice),
                          ),
                        );
                      },
                    ));
              },
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                color: const Color.fromARGB(150, 255, 239, 190),
                onPressed: () {
                  _goToHome;
                },
                icon: const Icon(Icons.home),
              ),
              IconButton(
                color: const Color.fromARGB(150, 255, 239, 190),
                onPressed: () {
                  _goToPanier(context, userId);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              IconButton(
                color: const Color.fromARGB(150, 255, 239, 190),
                onPressed: () {
                  _goToCommandes(context, userId);
                },
                icon: const Icon(Icons.history),
              ),
              IconButton(
                color: const Color.fromARGB(150, 255, 239, 190),
                onPressed: () {
                  _goToProfile(context, userId);
                },
                icon: const Icon(Icons.person),
              ),
            ],
          ),
        ));
  }
}
