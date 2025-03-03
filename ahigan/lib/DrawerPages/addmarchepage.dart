import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiselect/multiselect.dart';

class Addmarchepage extends StatefulWidget {
  const Addmarchepage({super.key});


  @override
  State<Addmarchepage> createState() => _AddmarchepageState();
}

class _AddmarchepageState extends State<Addmarchepage> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final nameController = TextEditingController();
  List<String> lieu = [];
  List<String> stand = [];
  List<String> categories = [];
  final CollectionReference stands = FirebaseFirestore.instance.collection('stands');

  Stream<QuerySnapshot>getStandWithCategorie(){

    final standsStream = stands.orderBy('timestamp', descending : true).snapshots();

    return standsStream;


  }

   
  


  final CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('stands');



Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    //final stand = querySnapshot.docs.map((doc) => doc.data()).toList();
    //print(stand);


}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un Marché'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(17),
          child: Column(
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.grey, width: 1.5)),
                title: Row(
                  children: [
                    Text('Nom'),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: nameController,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              DropDownMultiSelect(
                selectedValuesStyle: TextStyle(color: Colors.transparent),
                separator: '__',
                onChanged: (List<String> x) {
                  setState(() {
                    lieu = x;
                  });
                },
                options: ['Ganhi', 'Zogbo', 'Cadjehoun', 'Akpakpa', 'Agla'],
                selectedValues: lieu,
                whenEmpty: 'Select lieu',
              ),
              SizedBox(height: 10),
              DropDownMultiSelect(
                selectedValuesStyle: TextStyle(color: Colors.transparent),
                separator: '__',
                onChanged: (List<String> x) {
                  setState(() {
                    stand = x;
                  });
                },

                
                options: ['AB01', 'AB02', 'AB03', 'AB04', 'AB05'],
                selectedValues: stand,
                whenEmpty: 'Select stand',
              ),
              
              SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Color(0xFF9fd5cd)),
                onPressed: () {
                  FirebaseFirestore.instance.collection('marché').add({
                    'name': nameController.value.text,
                    'lieu': lieu,
                    'stand': stand,
                    'manager': '', // Champ manager vide
                    'category':[],
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Ajouter',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
