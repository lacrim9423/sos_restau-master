import 'package:flutter/material.dart';
import 'package:sos_restau/Categories/viande/meat.dart';
import 'package:flash/flash.dart';

class MeatCard extends StatefulWidget {
  final MeatProduct meat;
  final void Function(int quantity) onQuantityChanged;

  const MeatCard(
      {Key? key, required this.meat, required this.onQuantityChanged})
      : super(key: key);

  @override
  _MeatCardState createState() => _MeatCardState();
}

class _MeatCardState extends State<MeatCard> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            widget.meat.image,
            height: 80.0,
            width: 80.0,
          ),
          const SizedBox(height: 8.0),
          Text(
            widget.meat.name,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            widget.meat.description,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            '\$${widget.meat.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
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
                  widget.meat.available
                      ? Theme.of(context).primaryColor
                      : Colors.grey),
            ),
            child: Text(
                widget.meat.available ? 'Ajouter au panier' : 'Indisponible'),
          )
        ],
      ),
    );
  }
}
