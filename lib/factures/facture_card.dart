import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:sos_restau/factures/factures_page.dart';
import 'package:sos_restau/factures/pdf_viewer.dart';

class InvoiceCard extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> invoice;
  final String userId;

  const InvoiceCard({super.key, required this.invoice, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PDFViewerPage(fileUrl: invoice['fileUrl'], userId: userId),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Facture du ${invoice['date'].toDate().day}/${invoice['date'].toDate().month}/${invoice['date'].toDate().year}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Restaurant: ${invoice['restaurant']}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Total: ${invoice['total']} €",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
