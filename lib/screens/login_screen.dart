// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_assist/screens/home_screen.dart';
import 'package:grocery_assist/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            onPressed: () {
              //TODO: fix error handling
              try {
                final user = _auth.signInWithEmailAndPassword(
                    email: email, password: password);
                Navigator.pushNamed(context, HomeScreen.id);
              } catch (e) {
                print(e);
              }
            },
            child: Text('LOGIN'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Not registered?'),
              TextButton(
                onPressed: () {
                  //send to registration screen
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                child: Text('Create Account'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
