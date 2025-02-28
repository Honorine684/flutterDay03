import 'package:flutter/material.dart';

class AjoutProduit extends StatefulWidget {
  const AjoutProduit({super.key});

  @override
  State<AjoutProduit> createState() {
    return AjoutProduitState();
  }
}

class AjoutProduitState extends State<AjoutProduit> {
  final formKey = GlobalKey<FormState>();
  final nom = TextEditingController();
  final description = TextEditingController();
  final quantite = TextEditingController();
  final prix = TextEditingController();
  // Liste des produits prédéfinis
  final List<Map<String, String>> predefinedProducts = [
    {"nom": 'Produit', "image": "assets/images/aj3.jpg"},
    {"nom": 'Tomate', "image": "assets/images/aj3.jpg"},
    {"nom": 'Pomme de terre', "image": "assets/images/aj3.jpg"},
    {"nom": 'Oignon', "image": "assets/images/aj3.jpg"},
    {"nom": 'Carotte', "image": "assets/images/aj3.jpg"},
    {"nom": 'Poivron', "image": "assets/images/aj3.jpg"},
  ];

  // Liste des categorie prédéfinis
  final List<Map<String, String>> predefinedCategorie = [
    {"nom": 'Catégorie', "image": "assets/images/aj3.jpg"},
    {"nom": 'Nourriture', "image": "assets/images/aj3.jpg"},
    {"nom": 'Plastique', "image": "assets/images/aj3.jpg"},
    {"nom": 'Cosmétiques', "image": "assets/images/aj3.jpg"},
    {"nom": 'Divers', "image": "assets/images/aj3.jpg"},
    {"nom": 'Lampes', "image": "assets/images/aj3.jpg"},
  ];
  String dropdownValue1 = 'Catégorie';

  bool showTextFieldOther = false;
  String dropdownValue = 'Produit';

  final List<String> uniteMesure = [
    'Unité de mesure',
    'Kilo',
    'Gramme',
    'Pièce',
    'Panier',
    'Litre',
    'Mètre',
    'Sac',
    'Carton',
    'Paquet',
    'Millilitre',
    'Tonne'
  ];
  String selectedUnit = 'Unité de mesure';
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
              "Produit ajouté avec succès",
              style: TextStyle(color: Colors.teal.shade700),
            )
          ],
        );
      },
    );
  }

  void showAlertDialogConfirmProduit() {
    // Afficher une boîte de dialogue de confirmation
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Êtes-vous sûr de vouloir ajouter ce produit ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                // Logique d'enregistrement du produit ici
                Navigator.of(context).pop();

                //seconde boîte de dialogue pour confirmer l'ajout
                showAlertProductAdd();
              },
              child: Text("Confirmer"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    final hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 10,
        title: 
            Text(
              "Ajouter un produit",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
    
      ),
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
                  value: dropdownValue1,
                  isExpanded: true,
                  hint: const Text("Nom catégorie"),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: [
                    ...predefinedCategorie.map((categorie) {
                      return DropdownMenuItem<String>(
                        value: categorie["nom"],
                        child: Row(
                          children: [
                            Image.asset(
                              categorie["image"]!,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 10),
                            Text(categorie["nom"]!),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue1 = newValue!;
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
                    // Ajout d'options à la fin

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
                        // Ajoute un nouveau produit "Oignon" à la liste
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
                // quantité en stock
                SizedBox(
                  height: hauteurEcran * 0.03,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                    controller: quantite,
                    keyboardType: TextInputType.number,
                    // pour verifier si le champ est bien rempli
                    /*validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Vous devez entrez la quantité disponible";
                      }
                      return null;
                    },*/
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        suffixIcon:
                            const Icon(Icons.production_quantity_limits_sharp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        labelText: "Quantité",
                        hintText: "Quantité en stock"),
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
                DropdownButtonFormField<String>(
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
                  items: uniteMesure.map((unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
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
                                            AssetImage("assets/images/aj3.jpg"),
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
                                            AssetImage("assets/images/aj3.jpg"),
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
                                  image: AssetImage("assets/images/aj3.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: largeurEcran * 0.88,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      showAlertDialogConfirmProduit();
                      if (formKey.currentState!.validate()) {}
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
                      "Ajouter le produit",
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