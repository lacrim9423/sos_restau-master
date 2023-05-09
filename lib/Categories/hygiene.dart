// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:sos_restau/class/produit.dart';
// import 'package:sos_restau/models/product_card.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HygieneCategoryPage extends StatelessWidget {
//   final List<Product> products = [
//     Product(
//       name: 'Hand Sanitizer',
//       image: 'assets/images/hand_sanitizer.jpg',
//       price: 2.99,
//       available: true,
//       description: 'Keep your hands clean and fresh with this hand sanitizer.',
//     ),
//     Product(
//       name: 'Disinfectant Spray',
//       image: 'assets/images/disinfectant_spray.jpg',
//       price: 4.99,
//       available: true,
//       description: 'Clean and disinfect any surface with this spray.',
//     ),
//     Product(
//       name: 'Disposable Gloves',
//       image: 'assets/images/disposable_gloves.jpg',
//       price: 1.49,
//       available: true,
//       description: 'Protect your hands with these disposable gloves.',
//     ),
//     Product(
//       name: 'Face Mask',
//       image: 'assets/images/face_mask.jpg',
//       price: 0.99,
//       available: true,
//       description: 'Stay safe and protect others with this face mask.',
//     ),
//   ];

//   HygieneCategoryPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hygiène'),
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(8),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.7,
//           mainAxisSpacing: 8,
//           crossAxisSpacing: 8,
//         ),
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];
//           return ProductCard(
//             product: product,
//             title: product.name,
//             description: '',
//             imageUrl: product.image,
//             price: product.price,
//             available: product.available,
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_restau/class/produit.dart';
import 'package:sos_restau/models/product_card.dart';

class HygieneCategoryPage extends StatelessWidget {
  final CollectionReference hygieneCollection =
      FirebaseFirestore.instance.collection('hygiene');

  HygieneCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hygiène'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: hygieneCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Product> products = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Product(
              id: data['id'],
              name: data['nom'],
              image: data['image'],
              price: data['prix'],
              available: data['disponible'],
              description: data['description'],
            );
          }).toList();

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                title: product.name,
                description: product.description,
                imageUrl: product.image,
                price: product.price,
                available: product.available,
              );
            },
          );
        },
      ),
    );
  }
}
