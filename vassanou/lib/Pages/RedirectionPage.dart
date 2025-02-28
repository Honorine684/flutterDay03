import 'package:flutter/material.dart';
import 'package:vassanou/Authentification/Login.dart';
import 'package:vassanou/Pages/Home.dart';
import 'package:vassanou/Services/firebase/Auth.dart';

class Redirectionpage extends StatefulWidget {
  const Redirectionpage({super.key});

  @override
  State<Redirectionpage> createState() {
    return RedirectionpageState();
  }

}
class RedirectionpageState extends State<Redirectionpage>{
  @override
  Widget build(BuildContext context) {
   return StreamBuilder(
    stream: Auth().authStateChanges, 
    builder:(context,snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return const CircularProgressIndicator();
      }else if(snapshot.hasData){
        return const Home();
      }else{
        return const Login();
      }
    }
    );
  }
  
}