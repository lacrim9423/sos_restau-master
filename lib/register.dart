// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmailInputFb2 extends StatefulWidget {
  final TextEditingController inputController;
  final String hintText;

  const EmailInputFb2({
    required this.inputController,
    required this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  _EmailInputFb2State createState() => _EmailInputFb2State();
}

class _EmailInputFb2State extends State<EmailInputFb2> {
  Color primaryColor = Colors.grey;
  Color errorColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.inputController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: widget.hintText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: errorColor, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: errorColor, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          validator: (val) {
            if (val!.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
        const SizedBox(height: 10.0), // Add spacing between fields
      ],
    );
  }
}

class PasswordInput extends StatefulWidget {
  final String hintText;
  final TextEditingController textEditingController;

  const PasswordInput({
    required this.textEditingController,
    required this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool pwdVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.textEditingController,
          obscureText: !pwdVisibility,
          decoration: InputDecoration(
            hintText: widget.hintText,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(25.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(25.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(25.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(25.0),
            ),
            suffixIcon: InkWell(
              onTap: () => setState(() => pwdVisibility = !pwdVisibility),
              child: Icon(
                pwdVisibility
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.grey.shade400,
                size: 18,
              ),
            ),
          ),
          validator: (val) {
            if (val!.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
        const SizedBox(height: 10.0), // Add spacing between fields
      ],
    );
  }
}

class GradientButtonFb1 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GradientButtonFb1({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 239, 188, 21),
            Color.fromARGB(255, 230, 129, 15),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        textColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}

class RegisterPage1 extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();

  RegisterPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Bienvenue !',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Connectez-vous pour continuer',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),

              // Name field
              EmailInputFb2(
                inputController: _nameController,
                hintText: 'Nom',
              ),

              // Prénom field
              EmailInputFb2(
                inputController: _prenomController,
                hintText: 'Prénom',
              ),
              // Email field
              EmailInputFb2(
                inputController: _emailController,
                hintText: 'Email',
              ),
              // Password field
              PasswordInput(
                textEditingController: _passwordController,
                hintText: 'Mot de Passe',
              ),
              // Confirm password field
              PasswordInput(
                textEditingController: _confirmPasswordController,
                hintText: 'Confirmer MOt de Passe',
              ),
              // Register button
              GradientButtonFb1(
                text: 'Suivant',
                onPressed: () {
                  // Check if the passwords match
                  if (_passwordController.text ==
                      _confirmPasswordController.text) {
                    // Navigate to the next page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage2(
                          name: _nameController.text.trim(),
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          prenom: _prenomController.text.trim(),
                        ),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Mot de passe non identiques'),
                          content: const Text('Utilisez le même mot de passe.'),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterPage2 extends StatelessWidget {
  final String name;
  final String email;
  final String password;
  final String prenom;

  final TextEditingController _restaurantController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _licenseNumberController =
      TextEditingController();

  RegisterPage2({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.prenom,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2ème Étape'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Vous y êtes presque!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Restaurant field
              EmailInputFb2(
                inputController: _restaurantController,
                hintText: 'Nom du restaurant',
              ),
              // Address field
              EmailInputFb2(
                inputController: _addressController,
                hintText: 'Addresse du restaurant',
              ),
              // Phone number field
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Numéro de Téléphone',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0), // Add spacing between fields
              // License number field
              TextFormField(
                controller: _licenseNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Numéro de registre ',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0), // Add spacing between fields
              // Register button
              GradientButtonFb1(
                text: 'Suivant',
                onPressed: () {
                  // Register user and navigate to the home page
                  registerUser(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerUser(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store additional user information in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'nom': name,
        'motdepasse': password,
        'email': email,
        'restaurant': _restaurantController.text.trim(),
        'addresse': _addressController.text.trim(),
        'phone': _phoneNumberController.text.trim(),
        'registre': _licenseNumberController.text.trim(),
        'prenom': prenom,
      });

      // Navigate to home page or any other desired screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      // Handle registration errors
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Registration Failed'),
            content: Text('Error: $e'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
