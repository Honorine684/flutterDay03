import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // RECUperer l'user connecter
  User? get currentUser =>_firebaseAuth.currentUser;
  Stream<User?> get authStateChanges =>_firebaseAuth.authStateChanges();
  //LOGIN email and password
  Future<void> loginWithEmailAndPassword(String email,String password) async{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
  //logout
  Future<void> logout()async{
    await _firebaseAuth.signOut();
  }
  // creer user avec email et mdp
  Future<void> createUserWithEmailAndPassword(String email,String password)async{
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

}