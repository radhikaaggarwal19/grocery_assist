// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_assist/grocery_item.dart';

User? loggedInUser;
final _firestore = FirebaseFirestore.instance;

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  final listEditingController = TextEditingController();

  List<GroceryItem> groceryItems = [];
  String? itemString;
  GroceryItem? groceryItem;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  List<Widget> groceryTiles() {
    List<Widget> tiles = [];
    for (var item in groceryItems) {
      var tile = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.rectangle),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(item.itemName),
              TextButton(
                onPressed: () {
                  //implement 'Done' functionality
                },
                child: Icon(Icons.done),
              ),
              TextButton(
                onPressed: () {
                  //implement 'Remove' functionality
                  setState(() {
                    groceryItems.remove(item);
                  });
                },
                child: Icon(Icons.close),
              ),
            ],
          ),
        ),
      );
      tiles.add(tile);
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                //TODO: change color
                color: Color.fromARGB(255, 241, 213, 229),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Grocery List',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 40.0),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: listEditingController,
                                decoration: InputDecoration(
                                  hintText: "Add item...",
                                ),
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  itemString = value;
                                },
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (itemString != null) {
                                  setState(() {
                                    groceryItem =
                                        GroceryItem(itemName: itemString!);
                                    groceryItems.add(groceryItem!);
                                    print(groceryItems);
                                  });
                                  //TODO: fix data processing
                                  _firestore.collection('groceryLists').add({
                                    'items': {
                                      'addedBy': loggedInUser!.email,
                                      'itemName': groceryItem!.itemName,
                                      'itemDone': false,
                                    }
                                  });
                                  listEditingController.clear();
                                }
                              },
                              child: Text("Add"),
                            )
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Column(
                          children: groceryTiles(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 50.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.group,
                    size: 40.0,
                  ),
                  Icon(
                    Icons.home,
                    size: 40.0,
                  ),
                  Icon(
                    Icons.person,
                    size: 40.0,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
