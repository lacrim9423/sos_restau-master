import 'dart:io';
import 'cart_item.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> generateInvoice(List<CartItem> carts) async {
  final pdf = pw.Document();

  // Add the invoice header
  pdf.addPage(pw.Page(
    build: (pw.Context context) {
      return pw.Column(
        children: [
          pw.Text('INVOICE', style: pw.TextStyle(fontSize: 24)),
          pw.Text('Order Date: ${DateTime.now().toString()}',
              style: pw.TextStyle(fontSize: 16)),
          pw.SizedBox(height: 10),
        ],
      );
    },
  ));

  // Add the cart items to the invoice
  pdf.addPage(pw.Page(
    build: (pw.Context context) {
      return pw.Column(
        children: carts.map((cart) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Product: ${cart.name}'),
              pw.Text('Price: ${cart.price}'),
              pw.Text('Quantity: ${cart.quantity}'),
              pw.SizedBox(height: 10),
            ],
          );
        }).toList(),
      );
    },
  ));

  // Save the PDF file
  final file = File('invoice.pdf');
  await file.writeAsBytes(await pdf.save());
}
