import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vassanou/Authentification/Login.dart';
import 'package:vassanou/Pages/ParametresPage.dart';
import 'package:vassanou/Pages/StatisctiqueVente.dart';
import 'package:vassanou/Pages/revenueStatistiquePage.dart';
import 'package:vassanou/Services/firebase/Auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() {
    return ProfileState();
  }
}



class ProfileState extends State<Profile> {
  final password = TextEditingController();
  final ancienPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  bool showPassword = false;
  bool showConfirmPassword = false;
  final formKey = GlobalKey<FormState>();
  bool isReauthenticated = false;
  bool isLoading = false; // Variable pour afficher un état de chargement

  // Fonction pour réauthentifier l'utilisateur
  Future<void> reauthenticateUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        setState(() {
          isLoading = true; // Début du chargement
        });

        // Ré-authentifier avec l'ancien mot de passe
        final cred = EmailAuthProvider.credential(
          email: user.email!,
          password: ancienPassword.text,
        );

        await user.reauthenticateWithCredential(cred);

        setState(() {
          isReauthenticated = true; // Ré-authentification réussie
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ré-authentification réussie. Vous pouvez maintenant changer votre mot de passe.')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur de ré-authentification : ${e.toString()}')),
        );
        print('Erreur lors de la réauthentification : ${e.toString()}');
      } finally {
        setState(() {
          isLoading = false; // Fin du chargement
        });
      }
    }
  }

  // Fonction pour changer le mot de passe
  Future<void> changePassword() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Vérification que le mot de passe et la confirmation sont identiques
        if (password.text == confirmPassword.text) {
          await user.updatePassword(confirmPassword.text);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Mot de passe mis à jour avec succès'),
              backgroundColor: Colors.teal.shade700,
              ),
          );
          Navigator.pop(context); // Fermer la boîte de dialogue
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Les nouveaux mots de passe ne correspondent pas')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la mise à jour : ${e.toString()}')),
        );
      }
    }
  }

  void showAlertProductAdd() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            Image.asset(
              "assets/images/login.png",
              height: 200,
              fit: BoxFit.cover,
            ),
            Text(
              "Produit supprimé avec succès",
              style: TextStyle(color: Colors.teal.shade700),
            )
          ],
        );
      },
    );
  }

  void showAlertDialogConfirmprofil() {
    // Afficher une boîte de dialogue de confirmation
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Modification"),
          content:
              Text("Entrez les informations pour modifier le mot de passe"),
          actions: [
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.teal.shade700,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: TextFormField(
                        controller: ancienPassword,
                       // obscureText: !showPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mot de passe obligatoire";
                          } else if ((password.text).length < 6) {
                            return "Le mot de passe doit contenir plus de 6 caractères";
                          } else if (!RegExp(r'[a-zA-Z]')
                              .hasMatch(password.text)) {
                            return "Le mot de passe doit contenir des lettres";
                          } else if (!RegExp(r'\d').hasMatch(password.text)) {
                            return "Le mot de passe doit contenir des nombres";
                          } else if ((password.text).contains(' ')) {
                            return "Le mot de passe ne peut contenir d'espace";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: "Ancien mdp",
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              showPassword = !showPassword;
                            }),
                            icon: Icon(
                                 Icons.visibility
                                ),
                          ),
                        ),
                      ),
                    ),
                    // Mot de passe
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.teal.shade700,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: TextFormField(
                        controller: password,
                        //obscureText: !showPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mot de passe obligatoire";
                          } else if ((password.text).length < 6) {
                            return "Le mot de passe doit contenir plus de 6 caractères";
                          } else if (!RegExp(r'[a-zA-Z]')
                              .hasMatch(password.text)) {
                            return "Le mot de passe doit contenir des lettres";
                          } else if (!RegExp(r'\d').hasMatch(password.text)) {
                            return "Le mot de passe doit contenir des nombres";
                          } else if ((password.text).contains(' ')) {
                            return "Le mot de passe ne peut contenir d'espace";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              showPassword = !showPassword;
                            }),
                            icon: Icon(
                                 Icons.visibility
                                ),
                          ),
                        ),
                      ),
                    ),

                    // Confirmation du mot de passe
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.teal.shade700,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: TextFormField(
                        controller: confirmPassword,
                        //obscureText: !showConfirmPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Confirm password";
                          } else if (password.text != confirmPassword.text) {
                            return "Les mots de passe ne correspondent pas";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: "Confirmer",
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              showConfirmPassword = !showConfirmPassword;
                            }),
                            icon: Icon(
                                Icons.visibility
                                ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.teal.shade700),
                      child: TextButton(
                        onPressed: () => {
                          if (formKey.currentState!.validate()) {
                          changePassword()
                  }
                        },
                        child: Text(
                          "Modifier",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        );
      },
    );
  }

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
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              color: Color(0xffEBB65B), shape: BoxShape.circle),
          child: Center(
            child: IconButton(
                onPressed: () => {showAlertDialogConfirmprofil()},
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 24,
                )),
          )),
        SizedBox(
          width: 10,
        ),
        Text(
          "Changer mot de passe",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    ),
    IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right)),
  ],
),
Divider(thickness: 2, color: Colors.grey.withOpacity(0.5)),
SizedBox(
  height: 10,
),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              color: Color(0xffEBB65B), shape: BoxShape.circle),
          child: IconButton(
              onPressed: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Statisctiquevente()))
              },
              icon: Icon(
                Icons.sell,
                color: Colors.white,
              )),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "Ventes",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    ),
    IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right)),
  ],
),
Divider(thickness: 2, color: Colors.grey.withOpacity(0.5)),
SizedBox(
  height: 10,
),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              color: Color(0xffEBB65B), shape: BoxShape.circle),
          child: IconButton(
              onPressed: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> RevenueStatisticsPage()))
              },
              icon: Icon(
                Icons.money,
                color: Colors.white,
              )),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "Porte monnaie",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    ),
    IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right)),
  ],
),
Divider(thickness: 2, color: Colors.grey.withOpacity(0.5)),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              color: Color(0xffEBB65B), shape: BoxShape.circle),
          child: IconButton(
              onPressed: () async {
                final Uri url = Uri(scheme: 'tel', path: '0153827047');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  print("peut pas accéder à cet url");
                }
              },
              icon: Icon(
                Icons.call,
                color: Colors.white,
              )),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "Contactez le chef",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    ),
    IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right)),
  ],
),
Divider(thickness: 2, color: Colors.grey.withOpacity(0.5)),
SizedBox(
  height: 10,
),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              color: Color(0xffEBB65B), shape: BoxShape.circle),
          child: IconButton(
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ParametresPage()))
                  },
              icon: Icon(
                Icons.settings,
                color: Colors.white,
                size: 26,
              )),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "Paramètres",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    ),
    IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right)),
  ],
),
Divider(thickness: 2, color: Colors.grey.withOpacity(0.5)),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              color: Color(0xffEBB65B), shape: BoxShape.circle),
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
        SizedBox(
          width: 10,
        ),
        Text(
          "Déconnexion",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    ),
    IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right)),
  ],
),
Divider(thickness: 2, color: Colors.grey.withOpacity(0.5)),
Image.asset(
  "assets/images/user.jpg",
  width: largeurEcran * 0.7,
  height: 200,
),

  ]),
    ));
  }
}
