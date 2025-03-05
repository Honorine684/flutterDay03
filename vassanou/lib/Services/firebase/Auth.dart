import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vassanou/JsonModel/users.dart';

class Auth {
  //currentUser est une propriété native pour récuperer l'user connecté
  // alors que userCedential est une classe  utiliser pour stocker les infos de l'user immediatement apres login
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // RECUperer l'user connecter
  User? get currentUser =>_firebaseAuth.currentUser;
  Stream<User?> get authStateChanges =>_firebaseAuth.authStateChanges();
  //fonction pour stocker les données utilisateur
Future<void> createUserWithEmailAndPassword( {
  required String name,
  required String email, 
  required String password,
 String? pseudo,
  String? phoneNumber,
  String? categorieId,
  String? categorieLibelle,
  String? standId,
  String? numeroStand,
  String role = 'client'
}) async {
  try {
    // Créer l'utilisateur dans Authentication
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
    
    // Ajouter l'utilisateur à Firestore avec toutes les informations
    if (userCredential.user != null) { // si l'user est connecter ajoute ces elements a la bdd
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        /*'phoneNumber': phoneNumber,
        'categorieId': categorieId,
        'categorieLibelle': categorieLibelle,
        'pseudo':pseudo,
        'standId': standId,
        'numeroStand': numeroStand,*/
        'role': role,
        'timestamp': Timestamp.now(), 
        
      });
      
      // mettre à jour  disponibilité stand
     /* if (standId != null && standId.isNotEmpty) {
        await FirebaseFirestore.instance.collection('stands').doc(standId).update({
          'disponibilite': 'occupé',
          'utilisateurId': userCredential.user!.uid
        });
      }*/
    }
  } catch (e) {
    
    print("Erreur lors de la création de l'utilisateur: $e");
    throw e; 
  }
}
  //LOGIN email and password
 Future<Users?> loginWithEmailAndPassword(String email, String password) async {
  try {
    // Authentification avec Firebase Auth
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password
    );
    
    // Récupérer les données utilisateur depuis Firestore
    if (userCredential.user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
          
      // retourner users avec les données
      return Users(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email,
        name: userDoc.exists ? userDoc.get('name') : '',
        pseudo:userDoc.exists? userDoc.get('pseudo') : '',
        
      );
    }
    return null;
  } catch (e) {
    return null;
    
  }
}
  //logout
  Future<void> logout()async{
    await _firebaseAuth.signOut();
  }
  
}
