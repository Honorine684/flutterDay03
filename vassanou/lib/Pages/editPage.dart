import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vassanou/JsonModel/CategorieProduit.dart';
import 'package:vassanou/JsonModel/Produit.dart';
import 'package:vassanou/JsonModel/UniteMesure.dart';
import 'package:vassanou/Services/firebase/Auth.dart';
import 'package:vassanou/Services/firebase/FirestoreServices.dart';

class Editpage extends StatefulWidget {
  final Produit produit;
  const Editpage({super.key, required this.produit});

  @override
  State<Editpage> createState() {
    return EditpageState();
  }
}

class EditpageState extends State<Editpage> {
  final formKey = GlobalKey<FormState>();
  String? userCategorieCommerceId;

  final nom = TextEditingController();
  final photo = TextEditingController();
  final description = TextEditingController();
  final quantite = TextEditingController();
  final prix = TextEditingController();
  String? categorieProduitId;
  String? categorieProduitLibelle;
  String? uniteMesure;
  String? idMesure;
  

  @override
  void initState() {
    super.initState();
    getUserCategorieCommerce();
    loadMesures();
   
  }



  void getUserCategorieCommerce() async {
    try {
      // Récupérer l'utilisateur actuellement connecté
      final User? user = Auth().currentUser;
      if (user != null) {
        // Récupérer les données de l'utilisateur depuis Firestore
        final userData = await Firestoreservices().getUserData(user.uid);
        if (userData != null && userData.exists) {
          final categorieCommerceId = userData.get('categorieId');
          setState(() {
            userCategorieCommerceId = categorieCommerceId;
            print(
                "Catégorie de commerce de l'utilisateur: $userCategorieCommerceId");

            // Maintenant que nous avons l'ID, chargeons les catégories de produits
            if (userCategorieCommerceId != null) {
              loadCategories(userCategorieCommerceId!);
            }
          });
        }
      }
    } catch (e) {
      print("Erreur lors de la récupération de la catégorie de commerce: $e");
    }
  }

  List<Categorieproduit> categorieproduit = [];
  Categorieproduit? selectedProduit;
  void loadCategories(String categorieCommerceId) {
    print("Démarrage du chargement des catégories...");
    Firestoreservices().getCategorieProduit().listen((snapshot) {
      print("Données reçues: ${snapshot.docs.length} documents");
      List<Categorieproduit> categories = [];

      for (var doc in snapshot.docs) {
        if (categorieCommerceId == doc.get('categorieCommerceId')) {
          try {
            String categoryId = doc.id;
            String categorieCommerceId = doc.get('categorieCommerceId');
            String libelle = doc.get('libcat');
            String description = doc.get('description');
            String photo = doc.get('photo');

            print("Catégorie trouvée: $libelle (ID: $categoryId)");
            categories.add(Categorieproduit(
              id: categoryId,
              categorieCommerceId: categorieCommerceId,
              libelle: libelle,
              description: description,
              photo: photo,
            ));
          } catch (e) {
            print("Erreur sur un document: $e");
          }
        }
      }

      setState(() {
        categorieproduit = categories;
        print("Catégories chargées: ${categories.length}");
        if (categories.isNotEmpty && selectedProduit == null) {
          selectedProduit = categories[0];
          print("Catégorie par défaut: ${selectedProduit?.libelle}");
        }
      });
    }, onError: (error) {
      print("Erreur lors du chargement des catégories: $error");
    });
  }

  // Liste des produits prédéfinis
  final List<Map<String, String>> predefinedProducts = [
    {"nom": 'Produit', "image": "assets/images/aj3.jpg"},
    {"nom": 'Tomate', "image": "assets/images/aj3.jpg"},
    {"nom": 'Pomme de terre', "image": "assets/images/aj3.jpg"},
    {"nom": 'Oignon', "image": "assets/images/aj3.jpg"},
    {"nom": 'Carotte', "image": "assets/images/aj3.jpg"},
    {"nom": 'Poivron', "image": "assets/images/aj3.jpg"},
  ];

  bool showTextFieldOther = false;
  String dropdownValue = 'Produit';

  List<Mesures> Unitemesure = [];
  Mesures? selectedUnit;
  void loadMesures() {
    print("Démarrage du chargement des catégories...");
    Firestoreservices().getUniteMesure().listen((snapshot) {
      print("Données reçues: ${snapshot.docs.length} documents");
      List<Mesures> mesures = [];

      for (var doc in snapshot.docs) {
        try {
          String libelle = doc.get('libelle');
          String idMesure = doc.id;

          print("Mesures trouvée: $libelle (ID: $idMesure)");
          mesures.add(Mesures(id: idMesure, libelle: libelle));
        } catch (e) {
          print("Erreur sur un document: $e");
        }
      }

      setState(() {
        Unitemesure = mesures;
        print("Mesures chargées: ${mesures.length}");
        if (mesures.isNotEmpty && selectedUnit == null) {
          selectedUnit = mesures[0];
          print("mesures par défaut: ${selectedUnit?.libelle}");
        }
      });
    }, onError: (error) {
      print("Erreur lors du chargement des mesures: $error");
    });
  }

 // Récupère les données du produit depuis Firestore
  Future<void> fetchProduitData() async {
    DocumentSnapshot produitSnapshot = await FirebaseFirestore.instance
        .collection('produits')
        .doc(widget.produit.id)
        .get();

    if (produitSnapshot.exists) {
      var produitData = produitSnapshot.data() as Map<String, dynamic>;

      setState(() {
        nom.text = produitData['nom'];
        description.text = produitData['description'];
        prix.text = produitData['prixUnitaire'].toString();
        photo.text = produitData['photo'];
        categorieProduitId = produitData['CategorieProduitId'];
        categorieProduitLibelle = produitData['CategorieProduitLibelle'];
        uniteMesure = produitData['uniteMesure'];
        idMesure = produitData['idMesure'];
      });
    }
  }

 
  // Fonction de soumission du formulaire
  void submitForm() {
    if (formKey.currentState!.validate()) {
      double newPrixUnitaire = double.parse(prix.text);

     Firestoreservices(). 
     updateProduit(
        widget.produit.id,
        categorieProduitId??'',
        categorieProduitLibelle??'',
        nom.text,
        description.text,
        idMesure??'',
        uniteMesure??'',
        newPrixUnitaire,
        photo.text,
      );

     
      
    }
  }



  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    final hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 10,
          title: Text(
            "Modifier un produit",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/aj3.jpg",
                  width: largeurEcran * 0.88,
                  height: hauteurEcran * 0.4,
                ),
                SizedBox(
                  height: hauteurEcran * 0.02,
                ),
                // dropdown categorie
                DropdownButtonFormField<Categorieproduit>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  value: selectedProduit,
                  isExpanded: true,
                  hint: const Text("Nom catégorie"),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: categorieproduit.map((categorie) {
                    return DropdownMenuItem<Categorieproduit>(
                      value: categorie,
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/${categorie.photo}",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 10),
                          Text(categorie.libelle),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (Categorieproduit? newValue) {
                    setState(() {
                      selectedProduit = newValue!;
                    });
                  },
                ),
                SizedBox(
                  height: hauteurEcran * 0.03,
                ),
                // dropdown produit
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  value: dropdownValue,
                  isExpanded: true,
                  hint: const Text("Nom du produit"),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: [
                    ...predefinedProducts.map((product) {
                      return DropdownMenuItem<String>(
                        value: product["nom"],
                        child: Row(
                          children: [
                            Image.asset(
                              product["image"]!,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 10),
                            Text(product["nom"]!),
                          ],
                        ),
                      );
                    }).toList(),
                    

                    DropdownMenuItem(
                      value: 'Plus',
                      child: Text('Plus...'),
                    ),
                    DropdownMenuItem(
                      value: "Autre",
                      child: Text("Autre (Saisir manuellement)"),
                    )
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      if (newValue == 'Plus') {
                      } else if (newValue == 'Autre') {
                        dropdownValue = newValue!;
                        showTextFieldOther = true;
                      } else {
                        dropdownValue = newValue!;
                        showTextFieldOther = false;
                      }
                    });
                  },
                ),

                if (showTextFieldOther)
                  // champ nom produit
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                      controller: nom,
                      // pour verifier si le champ est bien rempli
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vous devez entrez le nom du produit";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[50],
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          suffixIcon:
                              const Icon(Icons.production_quantity_limits),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          labelText: "Produit",
                          hintText: "Nom du produit"),
                    ),
                  ),

                //Description
                SizedBox(
                  height: hauteurEcran * 0.03,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                    maxLines: 5,
                    controller: description,

                    // pour verifier si le champ est bien rempli
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Entrez une description pour permettre de mieux apprécier votre produit";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        suffixIcon: const Icon(Icons.description),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        labelText: "Description",
                        hintText: "Description du produit"),
                  ),
                ),

                // prix unitaire
                SizedBox(
                  height: hauteurEcran * 0.03,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                    controller: prix,
                    keyboardType: TextInputType.number,
                    // pour verifier si le champ est bien rempli
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Vous devez entrez le prix de votre produit";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        suffixIcon: const Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        labelText: "Prix/unité",
                        hintText: "Prix unitaire"),
                  ),
                ),
                // unité de mesure
                SizedBox(
                  height: hauteurEcran * 0.03,
                ),
                DropdownButtonFormField<Mesures>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  value: selectedUnit, // Valeur actuellement sélectionnée
                  isExpanded: true,
                  hint: const Text("Choisir l'unité de mesure"),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: Unitemesure.map((unit) {
                    return DropdownMenuItem<Mesures>(
                      value: unit,
                      child: Text(unit.libelle),
                    );
                  }).toList(),
                  onChanged: (Mesures? newValue) {
                    setState(() {
                      selectedUnit = newValue!;
                    });
                  },
                ),
                // container pour les photos
                SizedBox(height: hauteurEcran * 0.03),
                Text("Images de votre produit",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Container(
                  width: largeurEcran * 0.88,
                  height: hauteurEcran * 0.25,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      // Partie gauche avec deux images
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            // Image du haut à gauche
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image:
                                            AssetImage("assets/images/mar3.jpeg"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            // Divider horizontal
                            Divider(
                                height: 2,
                                thickness: 1,
                                color: Colors.grey.withOpacity(0.5)),
                            // Image du bas à gauche
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image:
                                            AssetImage("assets/images/mar1.jpeg"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Divider vertical
                      VerticalDivider(
                          width: 2,
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.5)),
                      // Partie droite avec une image
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: AssetImage("assets/images/mar3.jpeg"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ],
                  ),
                ),
                // lien photo
                SizedBox(
                  height: hauteurEcran * 0.03,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                    controller: photo,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        suffixIcon: const Icon(Icons.photo),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        labelText: "Photo",
                        hintText: "Lien photo"),
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: largeurEcran * 0.88,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      submitForm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      "Modifier le produit",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          )),
    );
  }
}
