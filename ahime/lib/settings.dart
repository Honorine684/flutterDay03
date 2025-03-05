import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Contrôleurs pour les champs de saisie
  TextEditingController _walletController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    // Initialiser les contrôleurs avec des valeurs par défaut
    _walletController.text = '10000'; 
    _nameController.text = 'oswald'; 
    _emailController.text = 'sossouvado@gmail.com'; // 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres' , style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF156651), 
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section : Mon Portefeuille
            _buildSectionTitle('Mon Portefeuille'),
            TextField(
              controller: _walletController,
              decoration: InputDecoration(
                labelText: 'Solde du portefeuille',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.account_balance_wallet),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final newBalance = _walletController.text;
                print('Nouveau solde du portefeuille : $newBalance CFA');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Solde mis à jour : $newBalance CFA'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF156651),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                'Sauvegarder',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),

            // Section : Informations Personnelles
            _buildSectionTitle('Informations Personnelles'),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nom',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final newName = _nameController.text;
                final newEmail = _emailController.text;
                print('Nouveau nom : $newName');
                print('Nouvel email : $newEmail');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Informations mises à jour'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF156651),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                'Mettre à jour',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),

            // Section : Notifications
            _buildSectionTitle('Notifications'),
            SwitchListTile(
              title: Text('Activer les notifications'),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                print('Notifications activées : $value');
              },
              activeColor: Color(0xFF156651),
            ),
            SizedBox(height: 20),

            // Section : Sécurité
            _buildSectionTitle('Sécurité'),
            ListTile(
              leading: Icon(Icons.lock, color: Color(0xFF156651)),
              title: Text('Changer le mot de passe'),
              onTap: () {
                // Ajouter la logique pour changer le mot de passe
                print('Changer le mot de passe');
              },
            ),
            SizedBox(height: 20),

            // Section : Aide et Support
            _buildSectionTitle('Aide et Support'),
            ListTile(
              leading: Icon(Icons.help, color: Color(0xFF156651)),
              title: Text('Centre d\'aide'),
              onTap: () {
                // Ajouter la logique pour accéder au centre d'aide
                print('Accéder au centre d\'aide');
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_support, color: Color(0xFF156651)),
              title: Text('Nous contacter'),
              onTap: () {
                // Ajouter la logique pour contacter le support
                print('Contacter le support');
              },
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour créer un titre de section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _walletController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
