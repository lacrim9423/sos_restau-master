import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_restau/factures.dart';
import 'package:sos_restau/historique.dart';
import 'package:sos_restau/home.dart';
import 'package:sos_restau/login.dart';
import 'package:sos_restau/panier.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _adresseController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _restaurantController = TextEditingController();
  bool _isEditing = false;
  late Map<String, dynamic> userData;

  @override
  void initState() {
    super.initState();
    _getUserData().then((data) {
      setState(() {
        userData = data;
        _nomController.text = userData['nom'];
        _prenomController.text = userData['prenom'];
        _emailController.text = userData['email'];
        _adresseController.text = userData['adresse'];
        _telephoneController.text = userData['phone'];
        _restaurantController.text = userData['restaurant'];
      });
    });
  }

  Future<Map<String, dynamic>> _getUserData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    final userDoc = await userRef.get();
    return userDoc.data() as Map<String, dynamic>;
  }

  void _goToPanier(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage(userId: userId)),
    );
  }

  void _goToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(
                userId: '',
              )),
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
        ),
      ),
    );
  }

  void _goToInvoices() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InvoicePage(
          userId: _auth.currentUser!.uid,
        ),
      ),
    );
  }

  Future<void> _updateUserData() async {
    if (_formKey.currentState!.validate()) {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      await userRef.update({
        'nom': _nomController.text,
        'prenom': _prenomController.text,
        'email': _emailController.text,
        'adresse': _adresseController.text,
        'phone': _telephoneController.text,
        'restaurant': _restaurantController.text,
      });
      setState(() {
        _isEditing = false;
        userData = {
          'nom': _nomController.text,
          'prenom': _prenomController.text,
          'email': _emailController.text,
          'adresse': _adresseController.text,
          'phone': _telephoneController.text,
          'restaurant': _restaurantController.text,
        };
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informations mises à jour avec succès.')),
      );
    }
  }

  Future<void> _logOut() async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
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
              title: const Text('Profil'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Historique des commandes'),
              onTap: _goToOrderHistory,
            ),
            // ListTile(
            //   title: const Text('Invoices'),
            //   onTap: _goToInvoices,
            // ),
            ListTile(
              title: const Text('Mode nuit'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Contacter nous'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Déconnecter'),
              onTap: _logOut,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16.0,
              ),
              const CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage('assets/images/placeholder.jpg'),
              ),
              const SizedBox(height: 16.0),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoCard(
                      title: 'Nom',
                      value: userData['nom'],
                      controller: _nomController,
                      isEditing: _isEditing,
                      hintText: 'Entrez votre nom',
                    ),
                    const SizedBox(height: 16.0),
                    _buildInfoCard(
                      title: 'Prénom',
                      value: userData['prenom'],
                      controller: _prenomController,
                      isEditing: _isEditing,
                      hintText: 'Entrez votre prénom',
                    ),
                    const SizedBox(height: 16.0),
                    _buildInfoCard(
                      title: 'Email',
                      value: userData['email'],
                      controller: _emailController,
                      isEditing: _isEditing,
                      hintText: 'Entrez votre email',
                    ),
                    const SizedBox(height: 16.0),
                    _buildInfoCard(
                      title: 'Adresse',
                      value: userData['adresse'],
                      controller: _adresseController,
                      isEditing: _isEditing,
                      hintText: 'Entrez votre adresse',
                    ),
                    const SizedBox(height: 16.0),
                    _buildInfoCard(
                      title: 'Téléphone',
                      value: userData['phone'],
                      controller: _telephoneController,
                      isEditing: _isEditing,
                      hintText: 'Entrez votre téléphone',
                    ),
                    const SizedBox(height: 16.0),
                    _buildInfoCard(
                      title: 'Restaurant',
                      value: userData['restaurant'],
                      controller: _restaurantController,
                      isEditing: _isEditing,
                      hintText: 'Entrez le nom de votre restaurant',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isEditing
                    ? _updateUserData
                    : () => setState(() => _isEditing = true),
                child: Text(_isEditing ? 'Sauvegarder' : 'Modifier'),
              ),
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
              onPressed: () => _goToHome(context),
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () => _goToPanier(context, _auth.currentUser!.uid),
              icon: const Icon(Icons.shopping_cart),
            ),
            IconButton(
              onPressed: () => _goToCommandes(context, _auth.currentUser!.uid),
              icon: const Icon(Icons.history),
            ),
            IconButton(
              onPressed: () => _goToProfile(context, _auth.currentUser!.uid),
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required TextEditingController controller,
    required bool isEditing,
    required String hintText,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                if (_isEditing)
                  IconButton(
                    onPressed: () => setState(() => _isEditing = false),
                    icon: const Icon(Icons.clear),
                  ),
              ],
            ),
            if (_isEditing)
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                ),
              )
            else
              Text(value),
          ],
        ),
      ),
    );
  }
}
