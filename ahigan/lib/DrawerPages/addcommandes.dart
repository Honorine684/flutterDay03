import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCommandePage extends StatefulWidget {
  const AddCommandePage({super.key});

  @override
  _AddCommandePageState createState() => _AddCommandePageState();
}

class _AddCommandePageState extends State<AddCommandePage> {
  final nomProduitController = TextEditingController();
  final numComController = TextEditingController();
  final prixController = TextEditingController();
  final userNameController = TextEditingController();
  bool isLoading = false;

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF156651)),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF156651), width: 2.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
    );
  }

  void _ajouterCommande() async {
    if (nomProduitController.text.isEmpty ||
        numComController.text.isEmpty ||
        prixController.text.isEmpty ||
        userNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }

    setState(() => isLoading = true);

    await FirebaseFirestore.instance.collection('commandes').add({
      'nomProduit': nomProduitController.text,
      'numCom': int.tryParse(numComController.text) ?? 0,
      'prix': double.tryParse(prixController.text) ?? 0.0,
      'userName': userNameController.text,
      'etat': 'en cours',
      'date': Timestamp.now(),
    });

    setState(() => isLoading = false);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajouter une Commande',
          style: TextStyle(color: Color(0xFF156651), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF156651)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          children: [
            TextField(
              controller: nomProduitController,
              decoration: _inputDecoration('Nom du Produit'),
              cursorColor: const Color(0xFF156651),
              style: const TextStyle(color: Color(0xFF156651)),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: numComController,
              decoration: _inputDecoration('Quantité'),
              keyboardType: TextInputType.number,
              cursorColor: const Color(0xFF156651),
              style: const TextStyle(color: Color(0xFF156651)),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: prixController,
              decoration: _inputDecoration('Prix'),
              keyboardType: TextInputType.number,
              cursorColor: const Color(0xFF156651),
              style: const TextStyle(color: Color(0xFF156651)),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: userNameController,
              decoration: _inputDecoration('Nom du Client'),
              cursorColor: const Color(0xFF156651),
              style: const TextStyle(color: Color(0xFF156651)),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF156651),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: isLoading ? null : _ajouterCommande,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Ajouter',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}