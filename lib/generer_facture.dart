import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> generateInvoice(
  String userId,
) async {
  // Initialize Firebase
  await Firebase.initializeApp();
  final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
  final factureRef = userRef.collection('factures').doc();

  // Fetch data from Firestore
  final factureSnapshot = await factureRef.get();
  final userSnapshot = await userRef.get();

  // Create PDF document
  final pdf = pw.Document();
  final invoiceNumber = factureSnapshot.id;
  final invoiceTitle = pw.Text('Facture $invoiceNumber',
      style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20));
  pdf.addPage(pw.MultiPage(
    pageFormat: PdfPageFormat.a4,
    margin: const pw.EdgeInsets.all(32),
    build: (pw.Context context) => [
      pw.Center(child: invoiceTitle),
      pw.SizedBox(height: 20),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Client : ${userSnapshot.get('nom')}',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.Text('Adresse : ${userSnapshot.get('adresse')}',
                  style: const pw.TextStyle(fontSize: 14)),
            ],
          ),
          pw.Text('Date : ${factureSnapshot.get('timestamp')}',
              style: const pw.TextStyle(fontSize: 14)),
        ],
      ),
      pw.SizedBox(height: 20),
      pw.Table.fromTextArray(
        context: context,
        data: <List<String>>[
          <String>['Produit', 'Quantité', 'Prix unitaire', 'Total'],
          ...factureSnapshot
              .get('items')
              .map<List<String>>((item) => [
                    item['name'],
                    '${item['quantity']}',
                    '${item['price']}',
                    '${item['total']}',
                  ])
              .toList(),
        ],
      ),
    ],
  ));

  // Save the PDF document to Firebase Cloud Storage
  final bytes = await pdf.save();
  final fileName = '${factureSnapshot.id}.pdf';
  final ref = FirebaseStorage.instance.ref().child(fileName);
  final uploadTask = ref.putData(bytes);
  await uploadTask.whenComplete(() {});

  // Update the Firestore document with the download URL
  final downloadURL = await ref.getDownloadURL();
  await factureRef.set({'downloadURL': downloadURL});
}
