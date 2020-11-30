import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task3/src/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task3/src/screens/view.dart';

import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameFieldController = TextEditingController();
  final deptFieldController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  User loggedInUser;
  String name;
  String department;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void detailsStream() async {
    await for (var snapshot
        in _firestore.collection('intern_details').snapshots()) {
      for (var detail in snapshot.docs) {
        print(detail.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900].withOpacity(0.2),
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
        backgroundColor: Colors.purple[900].withOpacity(0.2),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                auth.signOut().then((_) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                });
              }),
        ],
      ),
      body: SafeArea(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: nameFieldController,
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(hintText: 'Enter name'),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: deptFieldController,
                      onChanged: (value) {
                        department = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(hintText: 'Enter department'),
                    ),
                  ),
                  SizedBox(height: 20,),
                Container(
                  child: Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      color: Colors.white24,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),

                      ),
                      onPressed: () {
                        nameFieldController.clear();
                        deptFieldController.clear();
                        _firestore
                            .collection('intern_details')
                            .add({'name': name, 'department': department});
                      },
                      child: Text(
                        'Enter',
                        style: kButtonTextStyle,
                      ),
                    ),
                    SizedBox(width: 20,),
                    RaisedButton(
                        color: Colors.white24,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),

                        ),
                        child:Text(
                          'View',
                          style: kButtonTextStyle,
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => InternsList(firestore: _firestore)

                            ),
                          );
                        }),


                  ],
                ),

                ),

          ],
        ),
      ),
    );
  }
}
