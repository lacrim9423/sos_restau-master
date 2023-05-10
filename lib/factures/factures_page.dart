import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_restau/factures/facture_card.dart';
import 'package:sos_restau/factures/pdf_viewer.dart';

class InvoicesPage extends StatelessWidget {
  final String userId;

  const InvoicesPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('factures')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFViewerPage(
                        fileUrl: snapshot.data!.docs[index]['fileUrl'],
                        userId: userId,
                      ),
                    ),
                  );
                },
                child: InvoiceCard(
                  invoice: snapshot.data!.docs[index],
                  userId: userId,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
