import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task3/src/screens/home.dart';

class VerifyScreen extends StatefulWidget {

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;
  @override
  void initState() {
    user = auth.currentUser;
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
    checkEmailVerified();
    });
    user.sendEmailVerification();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              'An email has been sent to ${user.email},please verify'),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();

      Navigator.of(this.context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }

  }
}
