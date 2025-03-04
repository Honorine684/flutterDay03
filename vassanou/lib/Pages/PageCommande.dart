import 'package:flutter/material.dart';
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
  final libCat = TextEditingController();
  final codCat = TextEditingController();

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
                    controller: codCat,
                   
               
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
                        labelText: "Code",
                        hintText: "Code catégorie"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                    controller: libCat,
                  
               
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
                        labelText: "Libellé",
                        hintText: "Libellé catégorie"),
                  ),
                ),
                SizedBox(
                  width:largeurEcran*0.88,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      
                      if (formKey.currentState!.validate()) {
                        Firestoreservices().addCategorie(codCat.text, libCat.text);
                        
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