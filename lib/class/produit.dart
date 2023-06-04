// class Product {
//   final String name;
//   final String description;
//   final double price;
//   final String image;
//   final bool available;
//   String? flavor; // Add flavor property

//   Product({
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.image,
//     required this.available,
//     this.flavor, // Initialize flavor as null
//   });
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final String image;
  final double price;
  final bool available;
  final String description;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.available,
    required this.description,
  });
}
