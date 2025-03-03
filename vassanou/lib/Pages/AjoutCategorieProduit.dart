import 'package:flutter/material.dart';
import 'package:vassanou/JsonModel/CategorieCommerce.dart';
import 'package:vassanou/Services/firebase/FirestoreServices.dart';

class Ajoutcategorieproduit extends StatefulWidget {
  const Ajoutcategorieproduit ({super.key});

  @override
  State<Ajoutcategorieproduit > createState() {
    return AjoutcategorieproduitState();
  }
}

class AjoutcategorieproduitState extends State<Ajoutcategorieproduit> {
  final formKey = GlobalKey<FormState>();
  final codcat = TextEditingController();
  final libcat = TextEditingController();
  final photo = TextEditingController();
  final description = TextEditingController();
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
                      controller: codcat,
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
                          labelText: "Code",
                          hintText: "Code categorie"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                      controller: libcat,
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
                          labelText: "Libellé",
                          hintText: "Libellé categorie"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                      controller: description,
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
                          labelText: "Description",
                          hintText: "Description categorie"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                      controller:photo,
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
                          labelText: "Photo",
                          hintText: "photo categorie"),
                    ),
                  ),
                  SizedBox(
                    width: largeurEcran * 0.88,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (selectedCategory != null) {
                            Firestoreservices().addCategorieProduit(
                                selectedCategory!.id,
                                selectedCategory!.libelle,
                                codcat.text,
                                libcat.text,
                                description.text,
                                photo.text
                                );

                            // Afficher un message de succès
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Categorie ajouté avec succès ")));

                            // Vider les champs
                            codcat.clear();
                            libcat.clear();
                            description.clear();
                            photo.clear();
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
                        "Ajouter la categorie",
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
