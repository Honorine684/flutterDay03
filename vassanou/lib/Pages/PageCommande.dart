import 'package:flutter/material.dart';
import 'package:vassanou/JsonModel/Produit.dart';
import 'package:vassanou/Services/firebase/FirestoreServices.dart';

class Pagecommande  extends StatefulWidget{
  const Pagecommande({super.key});

  @override
  State<Pagecommande> createState() {
    return PagecommandeState();
  }

}
class PagecommandeState extends State<Pagecommande>{
  final formKey = GlobalKey<FormState>();
  final prix = TextEditingController();
List<Produit> produits = [];
  Produit? selectedProduit;
  void loadProduits() {
    print("Démarrage du chargement des produits...");
    Firestoreservices().getProduits().listen((snapshot) {
      print("Données reçues: ${snapshot.docs.length} documents");
      List<Produit> listeProduits = [];

      for (var doc in snapshot.docs) {
        try {
          
          String produitId = doc.id;
          String categorieProduitId = doc.get('categorieProduitId');
          String categorieProduitLibelle = doc.get('categorieProduitLibelle');
          String nom = doc.get('nom');
          String description = doc.get('description');
          String idMesure = doc.get('idMesure');
          String uniteMesure = doc.get('uniteMesure');
          double prixUnitaire = doc.get('prixUnitaire').toDouble();
          String photo = doc.get('photo');
          String userId = doc.get('userId');

          print("produits trouvée: $produitId (ID: $produitId)");
          listeProduits.add(Produit(
              id: produitId,
              categorieProduitId: categorieProduitId,
              categorieProduitLibelle: categorieProduitLibelle,
              nom: nom,
              description: description,
              idMesure: idMesure,
              uniteMesure: uniteMesure,
              prixUnitaire: prixUnitaire,
              photo: photo,
              userId: userId,
            ));
  
        
      } catch (e) {
          print("Erreur sur un document: $e");
        }
      }

      setState(() {
        produits = listeProduits;
        print("Produits chargées: $listeProduits{.length}");
        if (listeProduits.isNotEmpty && selectedProduit == null) {
          selectedProduit = listeProduits[0];
          print("produit par défaut: ${selectedProduit?.nom}");
        }
      });
    }, onError: (error) {
      print("Erreur lors du chargement des produits: $error");
    });
  }

    
  @override
  Widget build(BuildContext context) {
     final largeurEcran = MediaQuery.of(context).size.width;
   return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key :formKey,
          child: Column(
            children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                    controller: prix,
                  keyboardType: TextInputType.number,
               
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
                        labelText: "numero Commande",
                        hintText: "numero Commande"),
                  ),
                ),
                DropdownButtonFormField<Produit>(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.store),
                      border: InputBorder.none,
                      hintText: "Sélectionnez un produit",
                    ),
                    value: selectedProduit,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: produits.map((produit) {
                      return DropdownMenuItem<Produit>(
                        value: produit,
                        child: Text(produit.nom),
                      );
                    }).toList(),
                    onChanged: (Produit? newValue) {
                      setState(() {
                        selectedProduit = newValue;
                      });
                    },
                  ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                    controller: prix,
                  keyboardType: TextInputType.number,
               
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
                        labelText: "prix",
                        hintText: "prix"),
                  ),
                ),
                SizedBox(
                  width:largeurEcran*0.88,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      
                      if (formKey.currentState!.validate()) {
                        //Firestoreservices().addCategorie(codCat.text, libCat.text);
                        
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
                      "Ajouter la catégorie",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          )
        )
      ),
    );
  }
}