

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Statutcommande extends StatefulWidget {
  final String marketId;

  const Statutcommande({required this.marketId, super.key});

  @override
  State<Statutcommande> createState() => _AssignManagerPageState();
}

class _AssignManagerPageState extends State<Statutcommande> {
  final TextEditingController _managerController = TextEditingController();

  void _assignManager() {
    FirebaseFirestore.instance
        .collection('commandes')
        .doc(widget.marketId)
        .update({
      'manager': _managerController.text,
    }).then((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mettez Vendu'),
      ),
      body: Padding(
        padding: EdgeInsets.all(17),
        child: Column(
          children: [
            TextField(
              controller: _managerController,
              decoration: InputDecoration(
                labelText: 'Statut',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _assignManager,
              child: Text('Attribuer'),
            ),
          ],
        ),
      ),
    );
  }
}



