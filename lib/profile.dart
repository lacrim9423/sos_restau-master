import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_restau/factures.dart';
import 'package:sos_restau/historique.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nomController = TextEditingController();
  TextEditingController _adresseController = TextEditingController();
  TextEditingController _restaurantController = TextEditingController();

  Future<void> _getUserData() async {
    final user = _auth.currentUser;
    final userId = user!.uid;
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    setState(() {
      _nomController = userData.data()!['nom'];
      _emailController = userData.data()!['email'];
      _adresseController = userData.data()!['addresse'];
      _restaurantController = userData.data()!['restaurant'];
    });
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
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
              const SizedBox(
                height: 16.0,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                onChanged: (value) {
                  setState(() {
                    _nomController = value as TextEditingController;
                  });
                },
                controller: _nomController,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  enabled: false,
                ),
                controller: _emailController,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextField(
                  decoration: const InputDecoration(
                    labelText: 'Address',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _adresseController;
                    });
                  },
                  controller: _adresseController),
              const SizedBox(
                height: 16.0,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Restaurant Name',
                ),
                onChanged: (value) {
                  setState(() {
                    _restaurantController = value as TextEditingController;
                  });
                },
                controller: _restaurantController,
              ),
              const SizedBox(
                height: 32.0,
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: Update user data
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
