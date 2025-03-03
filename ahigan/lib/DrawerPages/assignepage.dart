
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssignManagerPage extends StatefulWidget {
  final String marketId;

  const AssignManagerPage({required this.marketId, super.key});

  @override
  State<AssignManagerPage> createState() => _AssignManagerPageState();
}

class _AssignManagerPageState extends State<AssignManagerPage> {
  final TextEditingController _managerController = TextEditingController();

  void _assignManager() {
    FirebaseFirestore.instance
        .collection('marché')
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
        title: Text('Attribuer un Manager'),
      ),
      body: Padding(
        padding: EdgeInsets.all(17),
        child: Column(
          children: [
            TextField(
              controller: _managerController,
              decoration: InputDecoration(
                labelText: 'Nom du Manager',
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
