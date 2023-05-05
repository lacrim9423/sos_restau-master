import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/Categories/pain/pain.dart';

class BreadCard extends StatefulWidget {
  final Bread bread;

  const BreadCard({Key? key, required this.bread}) : super(key: key);

  @override
  _BreadCardState createState() => _BreadCardState();
}

class _BreadCardState extends State<BreadCard> {
  int _quantity = 0;

  void _incrementQuantity() {
    setState(() {
      _quantity += 10;
    });
  }

  void _decrementQuantity() {
    setState(() {
      _quantity = _quantity == 0 ? 0 : _quantity - 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              widget.bread.image,
              height: 80,
              width: 80,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    widget.bread.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    widget.bread.description,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                Text(
                  '\$${widget.bread.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: _incrementQuantity,
              ),
              Text(
                _quantity.toString(),
                style: const TextStyle(fontSize: 18.0),
              ),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: _decrementQuantity,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: widget.bread.available
                ? () {
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
                  }
                : null,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  widget.bread.available
                      ? Theme.of(context).primaryColor
                      : Colors.grey),
            ),
            child: Text(
                widget.bread.available ? 'Ajouter au panier' : 'Indisponible'),
          ),
        ],
      ),
    );
  }
}
