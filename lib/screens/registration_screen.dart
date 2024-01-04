// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_assist/screens/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome to Grocery Assist',
          ),
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: CircleAvatar(
              //TODO: change for logo image later
              backgroundImage: AssetImage('images/sunset_app_logo.png'),
              radius: 100.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter your email',
            ),
            onChanged: (value) {
              email = value;
            },
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter your password',
            ),
            onChanged: (value) {
              password = value;
            },
            obscureText: true,
          ),
          TextButton(
            onPressed: () async {
              //TODO: implement login functionality
              try {
                final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                Navigator.pushNamed(context, HomeScreen.id);
              } catch (e) {
                print(e);
              }
            },
            child: Text('CREATE ACCOUNT'),
          ),
        ],
      ),
    );
  }
}
