import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommandeCard extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> commande;

  const CommandeCard({super.key, required this.commande});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: InkWell(
        onTap: () {
          // handle the card tap
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Commande du ${commande['date'].toDate().day}/${commande['date'].toDate().month}/${commande['date'].toDate().year}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Adresse: ${commande['adresse']}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Total: ${commande['total']} €",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Statut: ${commande['status']}",
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
