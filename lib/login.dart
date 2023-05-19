// // ignore_for_file: use_build_context_synchronously

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:sos_restau/home.dart';
// import 'package:sos_restau/register.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   //texte controllers
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _motDePasseController = TextEditingController();

//   Future<void> signIn() async {
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _motDePasseController.text.trim(),
//       );
//       // navigate to home page if sign in succeeds
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => HomePage()),
//       );
//     } on FirebaseAuthException catch (e) {
//       String errorMessage;
//       if (e.code == 'user-not-found') {
//         errorMessage = 'No user found for that email.';
//       } else if (e.code == 'wrong-password') {
//         errorMessage = 'Wrong password provided for that user.';
//       } else {
//         errorMessage = 'Error occurred while signing in: $e';
//       }
//       if (kDebugMode) {
//         print(errorMessage);
//       }
//       // Show an alert dialog with error message
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Error'),
//           content: Text(errorMessage),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 // Empty the email and password fields
//                 _emailController.clear();
//                 _motDePasseController.clear();
//                 Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error occurred while signing in: $e');
//       }
//       // Show an alert dialog with error message
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Error'),
//           content: Text('Error occurred while signing in: $e'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 // Empty the email and password fields
//                 _emailController.clear();
//                 _motDePasseController.clear();
//                 Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() async {
//     _emailController.dispose();
//     _motDePasseController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: SafeArea(
//           child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 25),

//             //Sos Restau
//             const Text(
//               'Sos Restau',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 36,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Vous Souhaite la Bienvenue',
//               style: TextStyle(
//                 fontSize: 18,
//               ),
//             ),
//             const SizedBox(height: 45),
//             // email textfield
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//               child: TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.white),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.deepPurple),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   hintText: 'Email',
//                   fillColor: Colors.grey[200],
//                   filled: true,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),

//             //Mot de passe textfield
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//               child: TextField(
//                 obscureText: true,
//                 controller: _motDePasseController,
//                 decoration: InputDecoration(
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.white),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.deepPurple),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   hintText: 'mot de passe',
//                   fillColor: Colors.grey[200],
//                   filled: true,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             // Padding(
//             //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.end,
//             //     children: [
//             //       GestureDetector(
//             //         onTap: () {
//             //           Navigator.push(
//             //             context,
//             //             MaterialPageRoute(
//             //               builder: (context) {
//             //                 return const oublilemotdepassepage();
//             //               },
//             //             ),
//             //           );
//             //         },
//             //         child: const Text(
//             //           'Mot de passe oublié?',
//             //           style: TextStyle(
//             //               color: Colors.blue, fontWeight: FontWeight.bold),
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             const SizedBox(height: 15),

//             //Sidentifier button
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//               child: GestureDetector(
//                 onTap: signIn,
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.deepPurple,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       'Sidentifier',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 25),

// ignore_for_file: use_build_context_synchronously

//             //pas membre/sincrire maintenant
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'pas membre?',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const RegisterPage()),
//                     );
//                   },
//                   child: const Text(
//                     'sincrire maintenant',
//                     style: TextStyle(
//                       color: Colors.blueAccent,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/home.dart';
import 'package:sos_restau/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = 'Error occurred while signing in: $e';
      }
      if (kDebugMode) {
        print(errorMessage);
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _emailController.clear();
                _passwordController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred while signing in: $e');
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Error occurred while signing in: $e'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _emailController.clear();
                _passwordController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              const Text(
                'Sos Restau',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Vous Souhaite la Bienvenue',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: EmailInputFb1(inputController: _emailController),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: PasswordInput(
                  textEditingController: _passwordController,
                  hintText: 'Mot de passe',
                  obscurePassword: _obscurePassword,
                  onToggleVisibility: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: signIn,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'pas membre?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage1(),
                        ),
                      );
                    },
                    child: const Text(
                      'sincrire maintenant',
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
        ),
      ),
    );
  }
}

class EmailInputFb1 extends StatelessWidget {
  final TextEditingController inputController;

  const EmailInputFb1({required this.inputController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.white.withOpacity(.9),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.1),
              ),
            ],
          ),
          child: TextField(
            controller: inputController,
            style: const TextStyle(fontSize: 14, color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool obscurePassword;
  final VoidCallback onToggleVisibility;

  const PasswordInput({
    required this.textEditingController,
    required this.hintText,
    required this.obscurePassword,
    required this.onToggleVisibility,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.white.withOpacity(.9),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.1),
              ),
            ],
          ),
          child: TextField(
            controller: textEditingController,
            obscureText: obscurePassword,
            style: const TextStyle(fontSize: 14, color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: IconButton(
                onPressed: onToggleVisibility,
                icon: Icon(
                  obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey.withOpacity(.75),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GradientButtonFb4 extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const GradientButtonFb4({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final double borderRadius = 25;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: const LinearGradient(
          colors: [Color(0xff53E88B), Color(0xff15BE77)],
        ),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          alignment: Alignment.center,
          padding: MaterialStateProperty.all(const EdgeInsets.only(
            right: 75,
            left: 75,
            top: 15,
            bottom: 15,
          )),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
