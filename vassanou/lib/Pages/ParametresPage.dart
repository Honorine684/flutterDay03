import 'package:flutter/material.dart';

class ParametresPage extends StatelessWidget {
  const ParametresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paramètres"),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Titre
            Text(
              "Bienvenue dans les Paramètres de Vassanou",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Informations générales
            Text(
              "Informations Générales",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Cette application de gestion de marché vous permet de suivre vos ventes, d'ajouter des produits, de gérer les commandes, et de communiquer avec vos clients via WhatsApp.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 20),

            // Paramètres de compte
            Text(
              "Paramètres de Compte",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Dans cette section, vous pouvez consulter les informations liées à votre compte utilisateur, comme votre nom, votre adresse e-mail, et vos préférences de notification.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 20),

            // Paramètres de notifications
            Text(
              "Paramètres de Notifications",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Vous pouvez configurer vos préférences de notifications afin de recevoir des alertes sur les nouvelles commandes, les mises à jour des produits et autres événements importants du marché.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 20),

            // Paramètres de langue
            Text(
              "Paramètres de Langue",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Cette application supporte plusieurs langues. Vous pouvez choisir la langue de votre choix pour une meilleure expérience utilisateur.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 20),

            // À propos
            Text(
              "À Propos",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "L'application de gestion de marché a été conçue pour simplifier la gestion des activités commerciales. Elle offre une interface intuitive et permet de suivre toutes les étapes des ventes de manière fluide.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 20),

            // Contact
            Text(
              "Contact",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Pour toute question ou support technique, vous pouvez nous contacter via notre adresse e-mail: support@vassanou.com.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 20),

            // Politique de confidentialité
            Text(
              "Politique de Confidentialité",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Nous nous engageons à protéger votre vie privée. Pour plus d'informations, consultez notre politique de confidentialité.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ParametresPage(),
  ));
}
