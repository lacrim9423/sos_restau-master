import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<File> generateInvoice(
    String userName,
    String restaurantName,
    String adresse,
    String orderId,
    String date,
    List<String> productNames,
    List<int> productQuantities,
    List<double> productPrices) async {
  final pdf = pw.Document();

  // Add title
  pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      build: (pw.Context context) => <pw.Widget>[
            pw.Center(
                child: pw.Text('Facture',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold))),
            pw.SizedBox(height: 20),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Nom du client: $userName'),
                pw.SizedBox(height: 10),
                pw.Text('Nom du restaurant: $restaurantName'),
                pw.SizedBox(height: 10),
                pw.Text('Adresse du restaurant: $adresse'),
                pw.SizedBox(height: 10),
                pw.Text('Numéro de commande: $orderId'),
                pw.SizedBox(height: 10),
                pw.Text('Date de commande: $date'),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
                context: context,
                data: <List<String>>[
                      <String>[
                        'Numéro',
                        'Désignation',
                        'Prix unitaire',
                        'Quantité',
                        'Prix total'
                      ]
                    ] +
                    List.generate(
                        productNames.length,
                        (index) => <String>[
                              (index + 1).toString(),
                              productNames[index],
                              '${productPrices[index]} €',
                              productQuantities[index].toString(),
                              '${productPrices[index] * productQuantities[index]} €'
                            ]),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellStyle: const pw.TextStyle()),
            pw.SizedBox(height: 20),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                'Total: ${productPrices.fold<double>(0, (prev, element) => prev + element)} €',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18),
              ),
            )
          ]));

  return File('${DateTime.now().millisecondsSinceEpoch}.pdf')
      .writeAsBytes(await pdf.save());
}





























// // Future<File> generateInvoice(
// //     String userName,
// //     String restaurantName,
// //     String adresse,
// //     String orderId,
// //     String date,
// //     List<String> productNames,
// //     List<int> productQuantities,
// //     List<double> productPrices) async {
// //   final pdf = pw.Document();

// //   // Add title
// //   pdf.addPage(pw.MultiPage(
// //       pageFormat: PdfPageFormat.a4,
// //       margin: const pw.EdgeInsets.all(32),
// //       build: (pw.Context context) => <pw.Widget>[
// //             pw.Center(
// //                 child: pw.Text('Facture',
// //                     style: pw.TextStyle(
// //                         fontSize: 24, fontWeight: pw.FontWeight.bold))),
// //             pw.SizedBox(height: 20),
// //             pw.Column(
// //               crossAxisAlignment: pw.CrossAxisAlignment.start,
// //               children: [
// //                 pw.Text('Nom du client: $userName'),
// //                 pw.SizedBox(height: 10),
// //                 pw.Text('Nom du restaurant: $restaurantName'),
// //                 pw.SizedBox(height: 10),
// //                 pw.Text('Adresse du restaurant: $adresse'),
// //                 pw.SizedBox(height: 10),
// //                 pw.Text('Numéro de commande: $orderId'),
// //                 pw.SizedBox(height: 10),
// //                 pw.Text('Date de commande: $date'),
// //               ],
// //             ),
// //             pw.SizedBox(height: 20),
// //             pw.Table.fromTextArray(
// //                 context: context,
// //                 data: <List<String>>[
// //                       <String>['Nom du produit', 'Quantité', 'Prix']
// //                     ] +
// //                     List.generate(
// //                         productNames.length,
// //                         (index) => <String>[
// //                               productNames[index],
// //                               productQuantities[index].toString(),
// //                               '${productPrices[index]} DZD'
// //                             ]),
// //                 headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
// //                 cellStyle: const pw.TextStyle()),
// //             pw.SizedBox(height: 20),
// //             pw.Align(
// //               alignment: pw.Alignment.centerRight,
// //               child: pw.Text(
// //                 'Total: ${productPrices.fold<double>(0, (prev, element) => prev + element)} €',
// //                 style:
// //                     pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18),
// //               ),
// //             )
// //           ]));

// //   return File('${DateTime.now().millisecondsSinceEpoch}.pdf')
// //       .writeAsBytes(await pdf.save());
// // }
// import 'dart:io';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// Future<File> generateInvoice(
//     String userName,
//     String restaurantName,
//     String adresse,
//     String orderId,
//     String date,
//     List<String> productNames,
//     List<int> productQuantities,
//     List<double> productPrices) async {
//   final pdf = pw.Document();

//   // Add title
//   pdf.addPage(pw.MultiPage(
//       pageFormat: PdfPageFormat.a4,
//       margin: const pw.EdgeInsets.all(32),
//       build: (pw.Context context) => <pw.Widget>[
//             pw.Center(
//                 child: pw.Text('Facture',
//                     style: pw.TextStyle(
//                         fontSize: 24, fontWeight: pw.FontWeight.bold))),
//             pw.SizedBox(height: 20),
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text('Nom du client: $userName'),
//                 pw.SizedBox(height: 10),
//                 pw.Text('Nom du restaurant: $restaurantName'),
//                 pw.SizedBox(height: 10),
//                 pw.Text('Adresse du restaurant: $adresse'),
//                 pw.SizedBox(height: 10),
//                 pw.Text('Numéro de commande: $orderId'),
//                 pw.SizedBox(height: 10),
//                 pw.Text('Date de commande: $date'),
//               ],
//             ),
//             pw.SizedBox(height: 20),
//             pw.Table.fromTextArray(
//                 context: context,
//                 data: <List<String>>[
//                       <String>['Nom du produit', 'Quantité', 'Prix']
//                     ] +
//                     List.generate(
//                         productNames.length,
//                         (index) => <String>[
//                               productNames[index],
//                               productQuantities[index].toString(),
//                               '${productPrices[index]} DZD'
//                             ]),
//                 headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                 cellStyle: const pw.TextStyle()),
//             pw.SizedBox(height: 20),
//             pw.Align(
//               alignment: pw.Alignment.centerRight,
//               child: pw.Text(
//                 'Total: ${productPrices.fold<double>(0, (prev, element) => prev + element)} €',
//                 style:
//                     pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18),
//               ),
//             )
//           ]));

//   return File('${DateTime.now().millisecondsSinceEpoch}.pdf')
//       .writeAsBytes(await pdf.save());
// }