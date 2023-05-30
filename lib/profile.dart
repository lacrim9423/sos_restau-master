// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_restau/factures.dart';
import 'package:sos_restau/historique.dart';
import 'package:sos_restau/home.dart';
import 'package:sos_restau/login.dart';
import 'package:sos_restau/panier.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    _getUserData().then((data) {
      setState(() {
        userData = data;
      });
    });
  }

  Future<Map<String, dynamic>> _getUserData() async {
    // Get the current user's ID
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Get a reference to the user's document in Firestore
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    // Retrieve the user's data from Firestore
    DocumentSnapshot userDoc = await userRef.get();

    // Return the user's data as a Map
    return userDoc.data() as Map<String, dynamic>;
  }

  void _goToPanier(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage(userId: userId)),
    );
  }

  void _goToHome(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
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

  void _goToOrderHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OrderHistoryPage(
                userId: _auth.currentUser!.uid,
              )),
    );
  }

  void _goToInvoices() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => InvoicePage(
                userId: _auth.currentUser!.uid,
              )),
    );
  }

  Future<void> _logOut() async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Menu'),
              ),
              ListTile(
                leading: const Icon(Icons.arrow_back),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Order History'),
                onTap: _goToOrderHistory,
              ),
              ListTile(
                title: const Text('Invoices'),
                onTap: _goToInvoices,
              ),
              ListTile(
                title: const Text('Switch to Dark Theme'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Contact Us'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                const CircleAvatar(
                  radius: 60.0,
                  backgroundImage: AssetImage('assets/images/placeholder.jpg'),
                ),
                ListTile(
                  title: Text('Nom: ${userData['nom']}'),
                ),
                ListTile(
                  title: Text('Prénom: ${userData['prenom']}'),
                ),
                ListTile(
                  title: Text('Email: ${userData['email']}'),
                ),
                ListTile(
                  title: Text('Adresse: ${userData['adresse']}'),
                ),
                ListTile(
                  title: Text('Téléphone: ${userData['telephone']}'),
                ),
                ListTile(
                  title: Text('Restaurant: ${userData['restaurant']}'),
                ),
                ElevatedButton(
                    onPressed: _logOut, child: const Text('Déconnecter'))
              ],
            ),
          ),
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
                  _goToPanier(
                    context,
                    _auth.currentUser!.uid,
                  );
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              IconButton(
                onPressed: () {
                  _goToCommandes(
                    context,
                    _auth.currentUser!.uid,
                  );
                },
                icon: const Icon(Icons.history),
              ),
              IconButton(
                onPressed: () {
                  _goToProfile(
                    context,
                    _auth.currentUser!.uid,
                  );
                },
                icon: const Icon(Icons.person),
              ),
            ],
          ),
        ));
  }
}
