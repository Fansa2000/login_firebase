import 'dart:ui';

import 'package:flutter/material.dart';

const kButtonTextStyle = TextStyle(

  color: Colors.blueGrey,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kTextFieldDecoration =InputDecoration(
  hintText: 'Enter your value.',
  hintStyle: TextStyle(color: Colors.blueGrey),
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.indigo, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(width: 2.0,
        color: Colors.indigo),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);


