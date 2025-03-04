
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class UsersPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informations Utilisateurs'),
        backgroundColor: Color(0xFF9fd5cd), // Couleur de l'app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Quelque chose s\'est mal passé'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.data!.docs.isEmpty) {
              return Center(child: Text('Aucun utilisateur trouvé'));
            }

            return ListView(
              children: snapshot.data!.docs.map((document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text(
                      data['name'] ?? '',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pseudo: ${data['pseudo'] ?? ''}'),
                        Text('Email: ${data['email'] ?? ''}'),
                        Text('Téléphone: ${data['phoneNumber'] ?? ''}'),
                        Text('Numéro de Stand: ${data['numeroStand'] ?? ''}'),
                        Text('Catégorie: ${data['categorieLibelle'] ?? ''}'),
                        Text('Role: ${data['role'] ?? ''}'),
                        Text('Stand ID: ${data['standId'] ?? ''}'),
                        Text('Date d\'inscription: ${data['timestamp']?.toDate().toString() ?? ''}'),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
