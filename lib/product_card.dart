import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/produit.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    Key? key,
    required this.product,
    required String description,
    required String title,
    required String imageUrl,
    required double price,
    required bool available,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _quantity = 0;
  String? _selectedFlavor; // Add selected flavor property

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(widget.product.image),
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
                if (widget.product.flavor != null) ...[
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Flavor:',
                        style: TextStyle(fontSize: 16),
                      ),
                      DropdownButton<String>(
                        value: _selectedFlavor,
                        items: widget.product.flavor!.split('/').map((f) {
                          return DropdownMenuItem<String>(
                            value: f,
                            child: Text(f),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedFlavor = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 10),
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
}
