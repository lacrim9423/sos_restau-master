import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sos_restau/login.dart';
import 'package:sos_restau/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAm3FAo4OtpqlYzJnpjaBQdkybAbq36jEs",
      authDomain: "sos-restau-a50ff.firebaseapp.com	",
      projectId: "sos-restau-a50ff",
      appId: '1:722566073390:android:f0ddedf84fbe12afce63bf',
      messagingSenderId: '722566073390',
    ),
  );

  runApp(const SosRestau());
}

class SosRestau extends StatelessWidget {
  const SosRestau({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Flutter App',
      theme: ThemeData(
        primaryColor: Colors.orange[200], // Set primary color to light orange
        scaffoldBackgroundColor: Colors.white, // Set background color to white
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange[200], // Set button color to light orange
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20), // Set button border radius to 20
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0, // Remove app bar shadow
          backgroundColor:
              Colors.white, // Set app bar background color to white
          iconTheme: IconThemeData(
            color: Colors.black, // Set app bar icon color to black
          ),
        ),
      ),
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initialement, affichez la page de connexion
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return const LoginPage();
    } else {
      return RegisterPage();
    }
  }
}
