import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil', style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF156651), // Couleur de l'appBar
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Section de la photo de profil et des informations
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/profile.png'), 
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Oswald DCLIC',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'sossouvadoe@gmail.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Section des options de profil
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildProfileOption(
                    icon: Icons.person,
                    title: 'Modifier le profil',
                    onTap: () {
                      // Action pour modifier le profil
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.settings,
                    title: 'Paramètres',
                    onTap: () {
                      // Action pour les paramètres
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.history,
                    title: 'Historique des commandes',
                    onTap: () {
                      // Action pour l'historique des commandes
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.help,
                    title: 'Aide et support',
                    onTap: () {
                      // Action pour l'aide et le support
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.logout,
                    title: 'Déconnexion',
                    onTap: () {
                      // Action pour la déconnexion
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour créer une option de profil
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF156651)),
      title: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
