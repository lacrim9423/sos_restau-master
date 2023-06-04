// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sos_restau/class/produit.dart';
// import 'package:sos_restau/models/product_card.dart';
// import 'package:sos_restau/historique.dart';
// import 'package:sos_restau/home.dart';
// import 'package:sos_restau/panier.dart';
// import 'package:sos_restau/profile.dart';

// class HygieneCategoryPage extends StatefulWidget {
//   const HygieneCategoryPage({Key? key}) : super(key: key);

//   @override
//   _HygieneCategoryPageState createState() => _HygieneCategoryPageState();
// }

// class _HygieneCategoryPageState extends State<HygieneCategoryPage> {
//   void _goToPanier(BuildContext context, String userId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CartPage(userId: userId)),
//     );
//   }

//   void _goToCommandes(BuildContext context, String userId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => OrderHistoryPage(userId: userId)),
//     );
//   }

//   void _goToHome(BuildContext context, String userId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const HomePage()),
//     );
//   }

//   void _goToProfile(BuildContext context, String userId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const ProfilePage()),
//     );
//   }

//   final CollectionReference hygieneCollection =
//       FirebaseFirestore.instance.collection('hygiene');

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     final userId = user?.uid ?? '';

//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Hygiène'),
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: hygieneCollection.snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return const Text('Something went wrong');
//             }

//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             final List<Product> products = snapshot.data!.docs.map((doc) {
//               final data = doc.data() as Map<String, dynamic>;
//               return Product(
//                 name: data['nom'],
//                 image: data['image'],
//                 price: data['prix'],
//                 available: data['disponible'],
//                 description: data['description'],
//               );
//             }).toList();

//             return GridView.builder(
//               padding: const EdgeInsets.all(8),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.7,
//                 mainAxisSpacing: 8,
//                 crossAxisSpacing: 8,
//               ),
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final product = products[index];
//                 return ProductCard(
//                   product: product,
//                   title: product.name,
//                   description: product.description,
//                   imageUrl: product.image,
//                   price: product.price,
//                   available: product.available,
//                 );
//               },
//             );
//           },
//         ),
//         bottomNavigationBar: BottomAppBar(
//           color: Colors.orange.shade50,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   _goToHome;
//                 },
//                 icon: const Icon(Icons.home),
//               ),
//               IconButton(
//                 onPressed: () {
//                   _goToPanier(context, userId);
//                 },
//                 icon: const Icon(Icons.shopping_cart),
//               ),
//               IconButton(
//                 onPressed: () {
//                   _goToCommandes(context, userId);
//                 },
//                 icon: const Icon(Icons.history),
//               ),
//               IconButton(
//                 onPressed: () {
//                   _goToProfile(context, userId);
//                 },
//                 icon: const Icon(Icons.person),
//               ),
//             ],
//           ),
//         ));
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/class/produit.dart';
import 'package:sos_restau/historique.dart';
import 'package:sos_restau/home.dart';
import 'package:sos_restau/models/product_card.dart';
import 'package:sos_restau/panier.dart';
import 'package:sos_restau/profile.dart';

class HygieneCategoryPage extends StatefulWidget {
  const HygieneCategoryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HygieneCategoryPageState createState() => _HygieneCategoryPageState();
}

class _HygieneCategoryPageState extends State<HygieneCategoryPage> {
  void _goToPanier(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage(userId: userId)),
    );
  }

  void _goToHome(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void _goToCommandes(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderHistoryPage(userId: userId)),
    );
  }

  void _goToProfile(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  final List<Product> _products = [];
  void _fetchlaitiersFromFirestore() {
    FirebaseFirestore.instance
        .collection('Products')
        .where('catégorie', isEqualTo: 'hygiene')
        .get()
        .then((querySnapshot) {
      final laitiers = querySnapshot.docs.map((doc) {
        final data = doc.data();

        return Product(
          name: data['nom'],
          description: data['description'],
          price: data['prix'],
          image: data['image'],
          available: data['disponible'],
        );
      }).toList();

      setState(() {
        _products.addAll(laitiers);
      });
    }).catchError((error) {
      if (kDebugMode) {
        print('Failed to fetch hygiene: $error');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchlaitiersFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';

    return Scaffold(
        appBar: AppBar(
          title: const Text('Lait et Dérivés'),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: _products.length,
          itemBuilder: (context, index) {
            final dairyProduct = _products[index];
            return ProductCard(
              product: dairyProduct,
              available: dairyProduct.available,
              description: dairyProduct.description,
              imageUrl: dairyProduct.image,
              price: dairyProduct.price,
              title: dairyProduct.name,
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.orange.shade50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  _goToHome;
                },
                icon: const Icon(Icons.home),
              ),
              IconButton(
                onPressed: () {
                  _goToPanier(context, userId);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              IconButton(
                onPressed: () {
                  _goToCommandes(context, userId);
                },
                icon: const Icon(Icons.history),
              ),
              IconButton(
                onPressed: () {
                  _goToProfile(context, userId);
                },
                icon: const Icon(Icons.person),
              ),
            ],
          ),
        ));
  }
}
