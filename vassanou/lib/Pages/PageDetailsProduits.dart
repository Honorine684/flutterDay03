import 'package:flutter/material.dart';
import 'package:vassanou/JsonModel/Produit.dart';

class PageDetailsProduits extends StatelessWidget {
  final Produit produit;
  
  const PageDetailsProduits({super.key, required this.produit});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(produit.nom),
        //backgroundColor: Colors.teal.shade700,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                "assets/images/${produit.photo}",
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              produit.nom,
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            SizedBox(height: 10),
            Text("Description",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            Text(
              produit.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Prix: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${produit.prixUnitaire} en ${produit.uniteMesure}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.teal.shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Catégorie: ${produit.categorieProduitLibelle}",
              style: TextStyle(fontSize: 16),
            ),
            
          ],
        ),
      ),
    );
  }
}