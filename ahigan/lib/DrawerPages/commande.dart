import 'package:ahigan/DrawerPages/addcommandes.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CommandePage extends StatefulWidget {
  const CommandePage({super.key});

  @override
  _CommandePageState createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {
  bool _showNonLivrees = true;
  Map<String, bool> _isLoading = {};

  Stream<QuerySnapshot> get _commandeStream {
    return FirebaseFirestore.instance
        .collection('commandes')
        .where('etat', isEqualTo: _showNonLivrees ? 'en cours' : 'livrée')
        .snapshots();
  }

  Future<void> _updateStatut(String documentId) async {
    setState(() {
      _isLoading[documentId] = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('commandes')
          .doc(documentId)
          .update({'etat': 'livrée'});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Commande marquée comme livrée !')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading[documentId] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Commandes',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF156651)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  height: 50,
                  width: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF9fd5cd)),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showNonLivrees = true;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: _showNonLivrees ? const Color(0xFF156651) : Colors.grey[300],
                          ),
                          child: Center(
                            child: Text(
                              'Non Livrées',
                              style: TextStyle(
                                color: _showNonLivrees ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showNonLivrees = false;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: !_showNonLivrees ? const Color(0xFF156651) : Colors.grey[300],
                          ),
                          child: Center(
                            child: Text(
                              'Livrées',
                              style: TextStyle(
                                color: !_showNonLivrees ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _commandeStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Une erreur s\'est produite.'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        _showNonLivrees ? 'Aucune commande en cours' : 'Aucune commande livrée',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    );
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

                      if (data == null || !data.containsKey('etat')) {
                        return const SizedBox();
                      }

                      String documentId = document.id;

                      return Card(
                        color: _showNonLivrees ? Color(0xFF156651) : Color(0xFF156651),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          title: Text(
                            data['nomProduit'] ?? 'Produit inconnu',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quantité: ${data['numCom'] ?? 'Non spécifié'}',
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              Text(
                                'Prix: ${data['prix'] ?? 'Non spécifié'}',
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              Text(
                                'Client: ${data['userName'] ?? 'Non spécifié'}',
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              if (!_showNonLivrees)
                                Text(
                                  'Statut: ${data['etat']}',
                                  style: const TextStyle(color: Color.fromARGB(255, 96, 201, 11), fontWeight: FontWeight.bold),
                                ),
                            ],
                          ),
                          trailing: _showNonLivrees
                              ? (_isLoading[documentId] == true
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF9fd5cd),
                                        textStyle: const TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        _updateStatut(documentId);
                                      },
                                      child: const Text(
                                        'Livrer',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                    ))
                              : const Icon(Icons.check, color: Colors.white),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF156651),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCommandePage()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
