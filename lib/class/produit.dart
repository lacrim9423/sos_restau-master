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
  final String id;
  final String name;
  final String image;
  final double price;
  final bool available;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.available,
    required this.description,
  });

  Future<int> getQuantity() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('hygiene').doc(id).get();
    final data = snapshot.data() as Map<String, dynamic>;
    return data['quantity'] as int;
  }
}
