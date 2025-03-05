import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({Key? key}) : super(key: key);

  // Fonction pour ouvrir une URL Google Maps
  void openGoogleMaps(String address) async {
    final Uri googleMapsUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$address");
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication); // Ouvre dans le navigateur ou l'application Maps
    } else {
      throw "Impossible d'ouvrir Google Maps.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> clients = [
      {"name": "John Doe", "address": "123 Main St, San Francisco"},
      {"name": "Jane Smith", "address": "456 Market St, Los Angeles"},
      {"name": "Sam Wilson", "address": "789 Broadway, New York"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Livraisons"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (context, index) {
          final client = clients[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.blueAccent),
              title: Text(client["name"]!),
              subtitle: Text(client["address"]!),
              trailing: const Icon(Icons.navigation, color: Colors.red),
              onTap: () {
                // Redirection vers Google Maps avec l'adresse
                openGoogleMaps(client["address"]!);
              },
            ),
          );
        },
      ),
    );
  }
}
