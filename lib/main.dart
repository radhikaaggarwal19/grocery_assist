// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_assist/screens/home_screen.dart';
import 'package:grocery_assist/screens/login_screen.dart';
import 'package:grocery_assist/screens/registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print('Firebase app initialization successful');
    runApp(GroceryAssist());
  } catch (e) {
    print('Error initializing Firebase App: $e');
  }
}

class GroceryAssist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: LoginScreen.id, routes: {
      LoginScreen.id: (context) => LoginScreen(),
      RegistrationScreen.id: (context) => RegistrationScreen(),
      HomeScreen.id: (context) => HomeScreen(),
    });
  }
}
