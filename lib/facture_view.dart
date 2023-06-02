// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';

// // class InvoiceDetailsPage extends StatelessWidget {
// //   final DocumentSnapshot invoice;

// //   const InvoiceDetailsPage({Key? key, required this.invoice}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     final invoiceId = invoice.id;
// //     final restaurantName = invoice.get('restaurant');
// //     final timestamp = invoice.get('timestamp');
// //     final formattedDate = DateFormat('yyyy-MM-dd')
// //         .format(DateTime.fromMillisecondsSinceEpoch(timestamp));

// //     final isPaid = invoice.get('paid');
// //     final items = invoice.get('items');

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Invoice Details'),
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             _buildHeader(),
// //             const SizedBox(height: 16.0),
// //             _buildClientInfo(),
// //             const SizedBox(height: 24.0),
// //             _buildInvoiceItems(),
// //             const SizedBox(height: 24.0),
// //             _buildTotalAmount(),
// //             const SizedBox(height: 24.0),
// //             _buildPaymentTerms(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildHeader() {
// //     return Row(
// //       children: [
// //         Image.asset(
// //           'assets/logo.png', // Replace with your logo image path
// //           width: 80.0,
// //           height: 80.0,
// //         ),
// //         const SizedBox(width: 16.0),
// //         Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: const [
// //             Text(
// //               'SOS Restau',
// //               style: TextStyle(
// //                 fontSize: 24.0,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //             Text(
// //               'Headquarters Address',
// //               style: TextStyle(
// //                 fontSize: 12.0,
// //                 color: Colors.grey,
// //               ),
// //             ),
// //           ],
// //         ),
// //         const Spacer(),
// //         Column(
// //           crossAxisAlignment: CrossAxisAlignment.end,
// //           children: [
// //             Text(
// //               'Invoice #: $',
// //               style: const TextStyle(
// //                 fontSize: 16.0,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //             Text(
// //               'Date: $invoiceDate',
// //               style: const TextStyle(
// //                 fontSize: 12.0,
// //                 color: Colors.grey,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildClientInfo() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Text(
// //           'Client Information:',
// //           style: TextStyle(
// //             fontSize: 16.0,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         const SizedBox(height: 8.0),
// //         Text(
// //           'Client Name: $res',
// //           style: const TextStyle(fontSize: 14.0),
// //         ),
// //         Text(
// //           'Address: $clientAddress',
// //           style: const TextStyle(fontSize: 14.0),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildInvoiceItems() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Text(
// //           'Invoice Items:',
// //           style: TextStyle(
// //             fontSize: 16.0,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         const SizedBox(height: 8.0),
// //         DataTable(
// //           columns: const [
// //             DataColumn(label: Text('Quantity')),
// //             DataColumn(label: Text('Description')),
// //             DataColumn(label: Text('Unit Price')),
// //             DataColumn(label: Text('Amount')),
// //           ],
// //           rows: items.map((item) {
// //             return DataRow(
// //               cells: [
// //                 DataCell(Text(item.quantity.toString())),
// //                 DataCell(Text(item.description)),
// //                 DataCell(Text(item.unitPrice.toString())),
// //                 DataCell(Text(item.amount.toString())),
// //               ],
// //             );
// //           }).toList(),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildTotalAmount() {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.end,
// //       children: [
// //         const Text(
// //           'Total Amount (excluding taxes): ',
// //           style: TextStyle(fontSize: 16.0),
// //         ),
// //         Text(
// //           '\$${totalAmount.toStringAsFixed(2)}',
// //           style: const TextStyle(
// //             fontSize: 16.0,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildPaymentTerms() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: const [
// //         Text(
// //           'Payment Terms:',
// //           style: TextStyle(
// //             fontSize: 16.0,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         SizedBox(height: 8.0),
// //         Text(
// //           'Payment is due within 30 days from the invoice date.',
// //           style: TextStyle(fontSize: 14.0),
// //         ),
// //       ],
// //     );
// //   }
// // }

// //  // @override
// //   // Widget build(BuildContext context) {
// //   //   final invoiceId = invoice.id;
// //   //   final restaurantName = invoice.get('restaurant');
// //   //   final timestamp = invoice.get('timestamp');
// //   //   final formattedDate = DateFormat('yyyy-MM-dd')
// //   //       .format(DateTime.fromMillisecondsSinceEpoch(timestamp));

// //   //   final isPaid = invoice.get('paid');
// //   //   final items = invoice.get('items');

// //   //   return Scaffold(
// //   //     appBar: AppBar(
// //   //       title: const Text('Invoice Details'),
// //   //     ),
// //   //     body: SingleChildScrollView(
// //   //       padding: const EdgeInsets.all(16.0),
// //   //       child: Column(
// //   //         crossAxisAlignment: CrossAxisAlignment.start,
// //   //         children: [
// //   //           Text('Invoice #$invoiceId',
// //   //               style: Theme.of(context).textTheme.headline6),
// //   //           const SizedBox(height: 16.0),
// //   //           Text('Restaurant: $restaurantName'),
// //   //           Text('Date: $formattedDate'),
// //   //           const SizedBox(height: 16.0),
// //   //           Text('Items:', style: Theme.of(context).textTheme.subtitle1),
// //   //           const SizedBox(height: 8.0),
// //   //           DataTable(
// //   //             columns: const [
// //   //               DataColumn(label: Text('Item')),
// //   //               DataColumn(label: Text('Quantity')),
// //   //               DataColumn(label: Text('Price')),
// //   //               DataColumn(label: Text('Total')),
// //   //             ],
// //   //             rows: items.map<DataRow>((item) {
// //   //               final itemName = item['name'];
// //   //               final itemQuantity = item['quantity'];
// //   //               final itemPrice = item['price'];
// //   //               final itemTotal = item['total'];

// //   //               return DataRow(cells: [
// //   //                 DataCell(Text(itemName)),
// //   //                 DataCell(Text(itemQuantity.toString())),
// //   //                 DataCell(Text(itemPrice.toString())),
// //   //                 DataCell(Text(itemTotal.toString())),
// //   //               ]);
// //   //             }).toList(),
// //   //           ),
// //   //           const SizedBox(height: 16.0),
// //   //           Row(
// //   //             children: [
// //   //               Icon(
// //   //                 isPaid ? Icons.check : Icons.close,
// //   //                 color: isPaid ? Colors.green : Colors.red,
// //   //               ),
// //   //               const SizedBox(width: 4.0),
// //   //               Text(
// //   //                 isPaid ? 'Payé' : 'Non payé',
// //   //                 style: TextStyle(
// //   //                   color: isPaid ? Colors.green : Colors.red,
// //   //                   fontWeight: FontWeight.bold,
// //   //                 ),
// //   //               ),
// //   //             ],
// //   //           ),
// //   //         ],
// //   //       ),
// //   //     ),
// //   //   );
// //   // }
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';

// // class InvoiceDetailsPage extends StatelessWidget {
// //   final DocumentSnapshot invoice;

// //   const InvoiceDetailsPage({Key? key, required this.invoice}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     final invoiceId = invoice.id;
// //     final restaurantName = invoice.get('restaurant');
// //     final timestamp = invoice.get('timestamp');
// //     final formattedDate = DateFormat('yyyy-MM-dd')
// //         .format(DateTime.fromMillisecondsSinceEpoch(timestamp));

// //     final items = invoice.get('items');
// //     final totalAmount = calculateTotalAmount(
// //         items); // Assuming you have a function to calculate the total amount

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Facture'),
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             _buildHeader(invoiceId, formattedDate),
// //             const SizedBox(height: 16.0),
// //             _buildClientInfo(restaurantName),
// //             const SizedBox(height: 24.0),
// //             _buildInvoiceItems(items),
// //             const SizedBox(height: 24.0),
// //             _buildTotalAmount(totalAmount),
// //             const SizedBox(height: 24.0),
// //             _buildPaymentTerms(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildHeader(String invoiceId, String invoiceDate) {
// //     return Row(
// //       children: [
// //         Image.asset(
// //           'assets/logo.png', // Replace with your logo image path
// //           width: 80.0,
// //           height: 80.0,
// //         ),
// //         const SizedBox(width: 16.0),
// //         Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: const [
// //             Text(
// //               'SOS Restau',
// //               style: TextStyle(
// //                 fontSize: 24.0,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //             Text(
// //               'Adresse Sos Restau',
// //               style: TextStyle(
// //                 fontSize: 12.0,
// //                 color: Colors.grey,
// //               ),
// //             ),
// //           ],
// //         ),
// //         const Spacer(),
// //         Column(
// //           crossAxisAlignment: CrossAxisAlignment.end,
// //           children: [
// //             Text(
// //               'Facture #: $invoiceId',
// //               style: const TextStyle(
// //                 fontSize: 16.0,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //             Text(
// //               'Date: $invoiceDate',
// //               style: const TextStyle(
// //                 fontSize: 12.0,
// //                 color: Colors.grey,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildClientInfo(String restaurantName) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const SizedBox(height: 8.0),
// //         Text(
// //           'Restaurant: $restaurantName',
// //           style: const TextStyle(fontSize: 14.0),
// //         ),
// //         // Add other client info fields if available
// //       ],
// //     );
// //   }

// //   Widget _buildInvoiceItems(List<dynamic> items) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         DataTable(
// //           columns: const [
// //             DataColumn(label: Text('Qté')),
// //             DataColumn(label: Text('Designation')),
// //             DataColumn(label: Text('Prix Unitaire')),
// //             DataColumn(label: Text('Total')),
// //           ],
// //           rows: items.map((item) {
// //             return DataRow(
// //               cells: [
// //                 DataCell(Text(item['quantity'].toString())),
// //                 DataCell(Text(item['description'])),
// //                 DataCell(Text(item['unitPrice'].toString())),
// //                 DataCell(Text(item['amount'].toString())),
// //               ],
// //             );
// //           }).toList(),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildTotalAmount(double totalAmount) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.end,
// //       children: [
// //         const Text(
// //           'Total Hors Taxe: ',
// //           style: TextStyle(fontSize: 16.0),
// //         ),
// //         Text(
// //           '${totalAmount.toStringAsFixed(2)} DZD',
// //           style: const TextStyle(
// //             fontSize: 16.0,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   double calculateTotalAmount(List<dynamic> items) {
// //     // Implement your logic to calculate the total amount
// //     double total = 0;
// //     for (var item in items) {
// //       total += item['amount'];
// //     }
// //     return total;
// //   }
// // }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvoiceDetailsPage extends StatelessWidget {
  final DocumentSnapshot invoice;

  const InvoiceDetailsPage({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final invoiceId = invoice.id;
    final restaurantName = invoice.get('restaurant') ?? 'N/A';
    final timestamp = invoice.get('timestamp');
    final formattedDate = timestamp != null
        ? DateFormat('yyyy-MM-dd')
            .format(DateTime.fromMillisecondsSinceEpoch(timestamp))
        : 'N/A';

    final items = invoice.get('items') ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(invoiceId, formattedDate),
            const SizedBox(height: 16.0),
            _buildClientInfo(restaurantName),
            const SizedBox(height: 24.0),
            _buildInvoiceItems(items),
            const SizedBox(height: 24.0),
            _buildTotalAmount(calculateTotalAmount(items)),
            const SizedBox(height: 24.0),
            _buildPaymentTerms(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String invoiceId, String invoiceDate) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'SOS Restau',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Headquarters Address',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'Facture #:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              invoiceId,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
            const Text(
              'Date:',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              invoiceDate,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildClientInfo(String restaurantName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Facturé À:',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Restaurant: $restaurantName',
          style: const TextStyle(fontSize: 14.0),
        ),
        // Add other client info fields if available
      ],
    );
  }

  Widget _buildInvoiceItems(List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0),
        DataTable(
          columns: const [
            DataColumn(label: Text('Quantité')),
            DataColumn(label: Text('Designation')),
            DataColumn(label: Text('Prix Unitaire')),
            DataColumn(label: Text('Total')),
          ],
          rows: items.map<DataRow>((item) {
            final quantity = item['quantity'] ?? 0;
            final description = item['name'] ?? 'N/A';
            final unitPrice = item['price'] ?? 0;
            final amount = item['total'] ?? 0;

            return DataRow(
              cells: [
                DataCell(Text(quantity.toString())),
                DataCell(Text(description)),
                DataCell(Text(unitPrice.toStringAsFixed(2))),
                DataCell(Text(amount.toStringAsFixed(2))),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTotalAmount(double totalAmount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Total (Hors taxes): ',
          style: TextStyle(fontSize: 16.0),
        ),
        Text(
          '\$${totalAmount.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentTerms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Modalités de paiement:',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Paiement dans les 30 jours.',
          style: TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }

  double calculateTotalAmount(List<dynamic> items) {
    double total = 0;
    for (var item in items) {
      final amount = item['total'] ?? 0;
      total += amount;
    }
    return total;
  }
}
