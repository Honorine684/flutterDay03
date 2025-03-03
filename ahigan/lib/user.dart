import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Utilisateur'),
        backgroundColor: Color(0xFF9fd5cd), // Couleur de l'app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF9fd5cd), // Couleur de l'arrière-plan de l'avatar
              child: Icon(
                Icons.person,
                size: 50,
                color: Color(0xFF0288D1), // Couleur de l'icône de l'avatar
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
                color: Color(0xFF9fd5cd), // Couleur de l'arrière-plan du conteneur
              ),
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(Icons.phone, color: Color(0xFF0288D1)), // Couleur de l'icône
                  SizedBox(width: 10),
                  Text(
                    '+123 456 7890',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF212121)), // Couleur du texte
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF9fd5cd), // Couleur de l'arrière-plan du conteneur
              ),
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Color(0xFF0288D1)), // Couleur de l'icône
                  SizedBox(width: 10),
                  Text(
                    'Adresse, Ville, Pays',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF212121)), // Couleur du texte
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
                    backgroundColor: Color(0xFF9fd5cd), // Couleur du bouton
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  icon: Icon(Icons.logout, color: Colors.white),
                  label: Text('Déconnexion'),
                  onPressed: () {
                    // Ajouter la fonctionnalité de déconnexion
                  },
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9fd5cd), // Couleur du bouton
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  icon: Icon(Icons.settings, color: Colors.white),
                  label: Text('Paramètres'),
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
