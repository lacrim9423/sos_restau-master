// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/home.dart';
import 'package:sos_restau/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _restaurantController = TextEditingController();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _motDePasseController = TextEditingController();
  final _motDePasseConfirmerController = TextEditingController();
  final _phoneController = TextEditingController();
  final _adresseController = TextEditingController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _motDePasseController.dispose();
    _motDePasseConfirmerController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    _phoneController.dispose();
    _adresseController.dispose();
    _restaurantController.dispose();
    super.dispose();
  }
////// authentifier l'utilisateur

  Future<void> signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _motDePasseController.text);
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (!passwordsMatch()) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Passwords do not match"),
                content: const Text("Please make sure your passwords match."),
                actions: [
                  ElevatedButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
        await firebaseFirestore.collection("users").doc(user.uid).set({
          "userId": user.uid.trim(),
          "nom": _nomController.text.trim(),
          "email": _emailController.text.trim(),
          "phone": _phoneController.text.trim(),
          "prenom": _prenomController.text.trim(),
          "restaurant": _restaurantController.text.trim(),
          "adresse": _adresseController.text.trim(),
          "motdepasse": _motDePasseController.text.trim()
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Le mot de passe est trop faible")));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ce compte existe déjà")));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  bool passwordsMatch() {
    return _motDePasseController.text == _motDePasseConfirmerController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25),

            //Sos Restau
            const Text(
              'Sos Restau',
            ),
            const SizedBox(height: 10),
            const Text(
              'Vous Souhaite la Bienvenue  inscrivez-vous ci-dessous avec vos coordonnées',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 45),

            // nom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _nomController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'nom',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // prènom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _prenomController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'prènom',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Email',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // numèro de tèlèphone
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'numèro de tèlèphone',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Adresse
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _adresseController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Adresse',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Socitè
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _restaurantController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Restaurant',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),

            //Mot de passe
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                obscureText: true,
                controller: _motDePasseController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'mot de passe',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // confirmer Mot de passe
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                obscureText: true,
                controller: _motDePasseConfirmerController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: ' confirmer mot de passe',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 15),

            //Sidentifier button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: signUp,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Sidentifier',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),

            //pas membre/sincrire maintenant
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'je suis membre!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    'Connecte-toi maintenant',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
