// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// Future<void> generateInvoice(
//   String userId,
// ) async {
//   // Initialize Firebase
//   await Firebase.initializeApp();
//   final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
//   final factureRef = userRef.collection('factures').doc();

//   // Fetch data from Firestore
//   final factureSnapshot = await factureRef.get();
//   final userSnapshot = await userRef.get();

//   // Create PDF document
//   final pdf = pw.Document();
//   final invoiceNumber = factureSnapshot.id;
//   final invoiceTitle = pw.Text('Facture $invoiceNumber',
//       style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20));
//   pdf.addPage(pw.MultiPage(
//     pageFormat: PdfPageFormat.a4,
//     margin: const pw.EdgeInsets.all(32),
//     build: (pw.Context context) => [
//       pw.Center(child: invoiceTitle),
//       pw.SizedBox(height: 20),
//       pw.Row(
//         crossAxisAlignment: pw.CrossAxisAlignment.start,
//         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//         children: [
//           pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text('Client : ${userSnapshot.get('nom')}',
//                   style: const pw.TextStyle(fontSize: 14)),
//               pw.Text('Adresse : ${userSnapshot.get('adresse')}',
//                   style: const pw.TextStyle(fontSize: 14)),
//             ],
//           ),
//           pw.Text('Date : ${factureSnapshot.get('timestamp')}',
//               style: const pw.TextStyle(fontSize: 14)),
//         ],
//       ),
//       pw.SizedBox(height: 20),
//       pw.Table.fromTextArray(
//         context: context,
//         data: <List<String>>[
//           <String>['Produit', 'Quantité', 'Prix unitaire', 'Total'],
//           ...factureSnapshot
//               .get('items')
//               .map<List<String>>((item) => [
//                     item['name'],
//                     '${item['quantity']}',
//                     '${item['price']}',
//                     '${item['total']}',
//                   ])
//               .toList(),
//         ],
//       ),
//     ],
//   ));

//   // Save the PDF document to Firebase Cloud Storage
//   final bytes = await pdf.save();
//   final fileName = '${factureSnapshot.id}.pdf';
//   final ref = FirebaseStorage.instance.ref().child(fileName);
//   final uploadTask = ref.putData(bytes);
//   await uploadTask.whenComplete(() {});

//   // Update the Firestore document with the download URL
//   final downloadURL = await ref.getDownloadURL();
//   await factureRef.set({'downloadURL': downloadURL});
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

// ...

Future<void> generateInvoices(String userId) async {
  final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
  final facturesQuerySnapshot = await userRef.collection('factures').get();

  final pdf = pw.Document();

  for (final doc in facturesQuerySnapshot.docs) {
    final facture = doc.data();
    final invoiceId = doc.id;

    final invoiceTitle = 'Invoice $invoiceId';
    final restaurantName = facture['restaurant'] ?? '';
    final userName = facture['nom'] ?? '';
    final timestamp = facture['timestamp'] ?? '';
    final totalPrice = facture['totalPrice'] ?? '';
    final items = facture['items'] ?? [];

    // Create a new page for each invoice
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          // Invoice header
          pw.Header(
            level: 0,
            child: pw.Text(invoiceTitle),
          ),
          pw.SizedBox(height: 20),
          pw.Text('Restaurant: $restaurantName'),
          pw.Text('Customer: $userName'),
          pw.Text('Timestamp: $timestamp'),
          pw.Divider(),
          pw.SizedBox(height: 20),

          // Invoice items
          pw.Table.fromTextArray(
            context: context,
            headerDecoration: pw.BoxDecoration(
              borderRadius: BorderRadius.all(2.0 as pw.Radius),
              color: PdfColors.grey300,
            ),
            data: [
              ['Product', 'Quantity', 'Price', 'Total'],
              ...items.map((item) => [
                    item['name'],
                    item['quantity'],
                    item['price'],
                    item['total'],
                  ]),
            ],
          ),
          pw.SizedBox(height: 20),

          // Invoice total
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text('Total: $totalPrice'),
            ],
          ),
        ],
      ),
    );
  }

  // Save the PDF file
  final output = await getTemporaryDirectory();
  final filePath = '${output.path}/invoices.pdf';
  final file = File(filePath);
  await file.writeAsBytes(await pdf.save());

  // Open the PDF file
  OpenFile.open(filePath);
}
