import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vassanou/Pages/RedirectionPage.dart';
import 'package:vassanou/firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MaterialApp(
    home: Redirectionpage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.teal.shade700,
      primarySwatch: Colors.teal,
      
    ),
  ));
}


