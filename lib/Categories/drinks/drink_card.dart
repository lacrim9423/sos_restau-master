import 'package:flutter/material.dart';
import 'package:sos_restau/Categories/drinks/drink.dart';

class DrinkCard extends StatefulWidget {
  final Drink drink;

  const DrinkCard({
    Key? key,
    required this.drink,
    required String title,
    required String imageUrl,
    required double price,
    required bool available,
    required String description,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DrinkCardState createState() => _DrinkCardState();
}

class _DrinkCardState extends State<DrinkCard> {
  String? _selectedFlavor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            widget.drink.image,
            fit: BoxFit.cover,
            height: 150.0,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.drink.name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.drink.description,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  '\$${widget.drink.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                if (widget.drink.flavors.isNotEmpty) ...[
                  DropdownButton<Flavor>(
                    value: _selectedFlavor != null
                        ? widget.drink.flavors.firstWhere(
                            (flavor) => flavor.id == _selectedFlavor!,
                            orElse: () => const Flavor(
                              id: '',
                              name: '',
                            ),
                          )
                        : null,
                    hint: const Text('Choisissez un parfum'),
                    items: widget.drink.flavors
                        .map((flavor) => DropdownMenuItem<Flavor>(
                              value: flavor,
                              child: Text(flavor.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedFlavor = value?.id;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                ],
                ElevatedButton(
                  onPressed: widget.drink.available
                      ? () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Commande ajoutée'),
                                content: Text(
                                    'Vous avez ajouté ${widget.drink.name.toLowerCase()}${_selectedFlavor != null ? ' au parfum ${widget.drink.flavors.firstWhere((flavor) => flavor.id == _selectedFlavor).name.toLowerCase()}' : ''} à votre commande.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        widget.drink.available
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                  ),
                  child: Text(widget.drink.available
                      ? 'Ajouter au panier'
                      : 'Indisponible'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
