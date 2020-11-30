import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task3/src/screens/home.dart';
import 'package:task3/src/screens/verify.dart';

import '../../constants.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String _email, _password;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.purple[900].withOpacity(0.2),
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(//color: Colors.white,
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
              keyboardType: TextInputType.emailAddress,
              decoration: kTextFieldDecoration.copyWith(hintText: 'Email'),

            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
              obscureText: true,
              decoration: kTextFieldDecoration.copyWith(hintText: 'Password'),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                  color: Colors.blueGrey,
                   shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text('Sign In',
                  style: kButtonTextStyle.copyWith(color: Colors.white70,)),
                  onPressed: () {
                    auth
                        .signInWithEmailAndPassword(
                            email: _email, password: _password)
                        .then((_) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    });
                  }),
              RaisedButton(
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text('Sign Up',
                  style: kButtonTextStyle.copyWith(color: Colors.white70),),
                onPressed: () {
                  auth.createUserWithEmailAndPassword(
                          email: _email, password: _password).then((_) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => VerifyScreen()));
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
