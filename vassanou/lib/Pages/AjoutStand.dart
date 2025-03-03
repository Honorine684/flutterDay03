import 'package:flutter/material.dart';
import 'package:vassanou/JsonModel/CategorieCommerce.dart';
import 'package:vassanou/Services/firebase/FirestoreServices.dart';

class Ajoutstand extends StatefulWidget {
  const Ajoutstand({super.key});

  @override
  State<Ajoutstand> createState() {
    return AjoutstandState();
  }
}

class AjoutstandState extends State<Ajoutstand> {
  final formKey = GlobalKey<FormState>();
  final emplacement = TextEditingController();
  final numeroStand = TextEditingController();
  final superficie = TextEditingController();
  List<Categoriecommerce> categorieCommerce = [];
  Categoriecommerce? selectedCategory;
  void loadCategories() {
    print("Démarrage du chargement des catégories...");
    Firestoreservices().getCategorieCommerce().listen((snapshot) {
      print("Données reçues: ${snapshot.docs.length} documents");
      List<Categoriecommerce> categories = [];

      for (var doc in snapshot.docs) {
        try {
          
          String categoryName = doc.get('libcat');
          String categoryId = doc.id; 

          print("Catégorie trouvée: $categoryName (ID: $categoryId)");
          categories
              .add(Categoriecommerce(id: categoryId, libelle: categoryName));
        } catch (e) {
          print("Erreur sur un document: $e");
        }
      }

      setState(() {
        categorieCommerce = categories;
        print("Catégories chargées: ${categories.length}");
        if (categories.isNotEmpty && selectedCategory == null) {
          selectedCategory = categories[0];
          print("Catégorie par défaut: ${selectedCategory?.libelle}");
        }
      });
    }, onError: (error) {
      print("Erreur lors du chargement des catégories: $error");
    });
  }

  @override
  void initState() {
    loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<Categoriecommerce>(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.store),
                      border: InputBorder.none,
                      hintText: "Sélectionnez une categorie",
                    ),
                    value: selectedCategory,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: categorieCommerce.map((categorie) {
                      return DropdownMenuItem<Categoriecommerce>(
                        value: categorie,
                        child: Text(categorie.libelle),
                      );
                    }).toList(),
                    onChanged: (Categoriecommerce? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                      controller: emplacement,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[50],
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          suffixIcon: const Icon(
                              Icons.production_quantity_limits_sharp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          labelText: "Emplacement",
                          hintText: "Emplacement du stand"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                      controller: superficie,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[50],
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          suffixIcon: const Icon(
                              Icons.production_quantity_limits_sharp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          labelText: "Superficie",
                          hintText: "Superficie stand"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                      controller: numeroStand,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[50],
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          suffixIcon: const Icon(
                              Icons.production_quantity_limits_sharp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          labelText: "Numero",
                          hintText: "Numero stand"),
                    ),
                  ),
                  SizedBox(
                    width: largeurEcran * 0.88,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (selectedCategory != null) {
                            Firestoreservices().addStand(
                                selectedCategory!.id,
                                emplacement.text,
                                superficie.text,
                                numeroStand.text);

                            // Afficher un message de succès
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Stand ajouté avec succès")));

                            // Vider les champs
                            emplacement.clear();
                            superficie.clear();
                            numeroStand.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Veuillez sélectionner une catégorie")));
                          }
                        }
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
                        "Ajouter le stand",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
