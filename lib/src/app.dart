import 'package:flutter/material.dart';
import 'package:task3/src/screens/login.dart';
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: ThemeData(
        accentColor: Colors.orange,
        primarySwatch: Colors.blue,
      ),
     home: LoginScreen(),
    );
  }
}
