import 'package:flutter/material.dart';
import 'package:vassanou/Authentification/Signup.dart';

void main() {
  runApp(MaterialApp(
    home: Signup(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.teal.shade700,
      primarySwatch: Colors.teal,
      
    ),
  ));
}


