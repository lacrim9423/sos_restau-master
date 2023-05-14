import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:url_launcher/url_launcher.dart';

class Invoice {
  final double total;
  final bool paid;
  final List<Map<String, dynamic>> items;

  Invoice({
    required this.total,
    required this.paid,
    required this.items,
  });
}

class InvoicePage extends StatelessWidget {
  final String userId;

  const InvoicePage({Key? key, required this.userId}) : super(key: key);

  Future<String> _getInvoiceUrl() async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('Invoice.pdf')
        .getDownloadURL();
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    final facturesRef = userRef.collection('factures');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: facturesRef.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error loading invoices: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = snapshot.data!.docs;

          if (documents.isEmpty) {
            return const Center(
              child: Text('No invoices found.'),
            );
          }

          final invoices = documents.map((document) {
            final items = List<Map<String, dynamic>>.from(document['items']);
            return Invoice(total: 0, paid: false, items: items);
          }).toList();

          return ListView.builder(
            itemCount: invoices.length,
            itemBuilder: (context, index) {
              final invoice = invoices[index];

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: \$${invoice.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          invoice.paid ? 'Paid' : 'Not paid',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: invoice.paid ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        String invoiceUrl = await _getInvoiceUrl();
                        if (await canLaunchUrl(invoiceUrl as Uri)) {
                          await launchUrl(invoiceUrl as Uri);
                        } else {
                          throw 'Could not launch $invoiceUrl';
                        }
                      },
                      child: const Text('Facture'),
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
