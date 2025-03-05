import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Utilisateur', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF156651), // Couleur de l'app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF156651), // Couleur de l'arrière-plan de l'avatar
              child: Icon(
                Icons.person,
                size: 50,
                color: Color.fromARGB(255, 96, 201, 11), // Couleur de l'icône de l'avatar
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nom de l\'Utilisateur',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121), // Couleur du texte
              ),
            ),
            SizedBox(height: 10),
            Text(
              'email@exemple.com',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF757575), // Couleur du texte secondaire
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF156651), // Couleur de l'arrière-plan du conteneur
              ),
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(Icons.phone, color: Color.fromARGB(255, 96, 201, 11),), // Couleur de l'icône
                  SizedBox(width: 10),
                  Text(
                    '+123 456 7890',
                    style: TextStyle(
                      fontSize: 16,
                      color :Colors.white), // Couleur du texte
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color :Color(0xFF156651), // Couleur de l'arrière-plan du conteneur
              ),
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Color.fromARGB(255, 96, 201, 11),), // Couleur de l'icône
                  SizedBox(width: 10),
                  Text(
                    'Adresse, Ville, Pays',
                    style: TextStyle(
                      fontSize: 16, color :Colors.white
                      ), // Couleur du texte
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF156651), // Couleur du bouton
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  icon: Icon(Icons.logout, color: Colors.white),
                  label: Text('Déconnexion',style: TextStyle(color :Colors.white)),
                  onPressed: () {
                    // Ajouter la fonctionnalité de déconnexion
                  },
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF156651), // Couleur du bouton
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  icon: Icon(Icons.settings, color: Colors.white),
                  label: Text('Paramètres',style: TextStyle(color :Colors.white),),
                  onPressed: () {
                    // Ajouter la fonctionnalité de paramétrage
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
