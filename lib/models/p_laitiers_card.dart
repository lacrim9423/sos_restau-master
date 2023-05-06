// ignore_for_file: library_private_types_in_public_api

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/class/p_laitiers.dart';

class DairyProductCard extends StatefulWidget {
  final DairyProduct product;

  const DairyProductCard({super.key, required this.product});

  @override
  _DairyProductCardState createState() => _DairyProductCardState();
}

class _DairyProductCardState extends State<DairyProductCard> {
  String? _selectedUnity;
  bool _isLiquid = true;
  int _quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              widget.product.image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Price: ${widget.product.price}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: _selectedUnity,
                  hint: const Text('Choisissez une unité'),
                  items: _isLiquid
                      ? const [
                          DropdownMenuItem(
                              value: 'Litre', child: Text('Litre')),
                        ]
                      : const [
                          DropdownMenuItem(
                              value: 'Gramme', child: Text('Gramme')),
                          DropdownMenuItem(
                              value: 'Kilogramme', child: Text('Kilogramme')),
                        ],
                  onChanged: (value) {
                    setState(() {
                      _selectedUnity = value!;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Quantity:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _quantity = _quantity > 0 ? _quantity - 1 : 0;
                            });
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(
                          '$_quantity',
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _quantity += 1;
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    showFlash(
                      context: context,
                      duration: const Duration(seconds: 2),
                      builder: (_, controller) {
                        return Flash(
                          controller: controller,
                          behavior: FlashBehavior.floating,
                          position: FlashPosition.bottom,
                          margin: const EdgeInsets.all(16),
                          borderRadius: BorderRadius.circular(8),
                          backgroundColor: Colors.grey[900]!,
                          child: const DefaultTextStyle(
                            style: TextStyle(color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text('Produit ajouté au panier!'),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        widget.product.available
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                  ),
                  child: Text(widget.product.available
                      ? 'Ajouter au panier'
                      : 'Indisponible'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //     child: Column(
  //       children: [
  //         Image.network(widget.product.image),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Column(
  //             children: [
  //               Text(
  //                 widget.product.name,
  //                 style: const TextStyle(fontSize: 20),
  //               ),
  //               const SizedBox(height: 8),
  //               Text(
  //                 widget.product.description,
  //                 textAlign: TextAlign.center,
  //               ),
  //               const SizedBox(height: 8),
  //               Text(
  //                 '${widget.product.price.toStringAsFixed(2)} €',
  //                 style: const TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 18,
  //                 ),
  //               ),
  //               const SizedBox(height: 8),
  //               DropdownButton<String>(
  //                 value: _selectedUnity,
  //                 hint: const Text('Choisissez une unité'),
  //                 items: _isLiquid
  //                     ? const [
  //                         DropdownMenuItem(
  //                             value: 'Litre', child: Text('Litre')),
  //                       ]
  //                     : const [
  //                         DropdownMenuItem(
  //                             value: 'Gramme', child: Text('Gramme')),
  //                         DropdownMenuItem(
  //                             value: 'Kilogramme', child: Text('Kilogramme')),
  //                       ],
  //                 onChanged: (value) {
  //                   setState(() {
  //                     _selectedUnity = value!;
  //                   });
  //                 },
  //               ),
  //               Center(
  //                 child: Row(
  //                   children: [
  //                     IconButton(
  //                       onPressed: () {
  //                         setState(() {
  //                           _quantity = _quantity > 0 ? _quantity - 1 : 0;
  //                         });
  //                       },
  //                       icon: const Icon(Icons.remove),
  //                     ),
  //                     Text(
  //                       '$_quantity',
  //                       style: const TextStyle(fontSize: 16),
  //                     ),
  //                     IconButton(
  //                       onPressed: () {
  //                         setState(() {
  //                           _quantity += 1;
  //                         });
  //                       },
  //                       icon: const Icon(Icons.add),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               ElevatedButton(
  //                 onPressed: widget.product.available
  //                     ? () {
  //                         showFlash(
  //                           context: context,
  //                           duration: const Duration(seconds: 2),
  //                           builder: (_, controller) {
  //                             return Flash(
  //                               controller: controller,
  //                               behavior: FlashBehavior.floating,
  //                               position: FlashPosition.bottom,
  //                               margin: const EdgeInsets.all(16),
  //                               borderRadius: BorderRadius.circular(8),
  //                               backgroundColor: Colors.grey[900]!,
  //                               child: const DefaultTextStyle(
  //                                 style: TextStyle(color: Colors.white),
  //                                 child: Padding(
  //                                   padding: EdgeInsets.all(8),
  //                                   child: Text('Produit ajouté au panier!'),
  //                                 ),
  //                               ),
  //                             );
  //                           },
  //                         );
  //                       }
  //                     : null,
  //                 style: ButtonStyle(
  //                   backgroundColor: MaterialStateProperty.all<Color>(
  //                       widget.product.available
  //                           ? Theme.of(context).primaryColor
  //                           : Colors.grey),
  //                 ),
  //                 child: Text(widget.product.available
  //                     ? 'Ajouter au panier'
  //                     : 'Indisponible'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
