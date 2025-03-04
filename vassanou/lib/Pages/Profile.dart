import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vassanou/Authentification/Login.dart';
import 'package:vassanou/Services/firebase/Auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
// Variables pour stocker les données utilisateur
  String name = "";
  String pseudo = "";
  String email = "";

  // Récupérer les informations de l'utilisateur depuis Firestore
  Future<void> getUserData() async {
    try {
      final User? currentUser = Auth().currentUser;
      if (currentUser != null) {
        // Récupérer les données utilisateur de Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            name = userDoc.get('name') ?? '';
            pseudo = userDoc.get('pseudo') ?? '';
            email = currentUser.email ?? '';
          });
        }
      }
    } catch (e) {
      print("Erreur lors de la récupération des données utilisateur: $e");
    }
  }

  // recupere la premiere lettre de son nom
  String getFirstLetter(String name) {
    return name.isNotEmpty ? name[0] : ''; // Retourne la première lettre
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;
    final largeurEcran = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [Icon(Icons.settings)],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
          
            Row(
              children: [
                Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.teal.shade700),
                    child: Center(
                        child: Text(
                      getFirstLetter(name),
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ))),
                SizedBox(
                  width: 60,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      pseudo,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      user?.email ?? "User email",
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.teal.shade700,
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Modifier profil",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Color(0xffE9494F), shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () => {}, icon: Icon(Icons.person,color: Colors.white,)),
                ),
                SizedBox(width: 10,),
                Text(
                  "Informations personnelles",
                  style: TextStyle(fontSize: 15,),
                ),
                SizedBox(
                  width: 40,
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right))
              ],
            ),
            Divider(thickness: 2, color: Colors.grey.withOpacity(0.5)),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Color(0xffE9494F), shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () => {}, icon: Icon(Icons.sell,color: Colors.white,)),
                ),
                SizedBox(width: 10,),
                Text(
                  "Ventes",
                  style: TextStyle(fontSize: 15, ),
                ),
                SizedBox(
                  width: 170,
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right))
              ],
            ),
            Divider(thickness: 2, color: Colors.grey.withOpacity(0.5)),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Color(0xffE9494F), shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () => {}, icon: Icon(Icons.money,color: Colors.white,)),
                ),
                SizedBox(width: 10,),
                Text(
                  "Porte monnaie",
                  style: TextStyle(fontSize: 15, ),
                ),
                SizedBox(
                  width: 110,
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right))
              ],
            ),
            Divider(thickness: 2, color: Colors.grey.withOpacity(0.5)),

            Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Color(0xffE9494F), shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () => {}, icon: Icon(Icons.call,color: Colors.white,)),
                ),
                SizedBox(width: 10,),
                Text(
                  "Contactez le chef",
                  style: TextStyle(fontSize: 15, ),
                ),
                SizedBox(
                  width: 90,
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right))
              ],
            ),
            Divider(thickness: 2, color: Colors.grey.withOpacity(0.5)),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Color(0xffE9494F), shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () => {}, icon: Icon(Icons.settings,color: Colors.white,)),
                ),
                SizedBox(width: 10,),
                Text(
                  "Paramètres",
                  style: TextStyle(fontSize: 15, ),
                ),
                SizedBox(
                  width: 115,
                ),
                IconButton(onPressed: () {
                  
                }, icon: Icon(Icons.chevron_right))
              ],
            ),
            Divider(thickness: 2, color: Colors.grey.withOpacity(0.5)),
            Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(0xffE9494F),shape: BoxShape.circle
                  ),
                  child: IconButton(
                  onPressed: () {
                    Auth().logout();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const Login()),
                      (route) => false,
                    ); // supprime les routes precedentes
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Color(0xffffffff),
                  ),
                ),
                ),
                SizedBox(width: 10,),
                Text(
                  "Déconnexion",
                  style: TextStyle(fontSize: 15, ),
                ),
                SizedBox(
                  width: 110,
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right))
              ],
            ),
            Divider(thickness: 2, color: Colors.grey.withOpacity(0.5)),
            Image.asset(
              "assets/images/user.jpg",
              width: largeurEcran * 0.7,
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}
