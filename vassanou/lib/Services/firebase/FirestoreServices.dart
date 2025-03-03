import 'package:cloud_firestore/cloud_firestore.dart';

class Firestoreservices {

//recuperer la collectio produit
final CollectionReference Produits = FirebaseFirestore.instance.collection('Produits');
//ajouter un nouveau produit
Future<Future<DocumentReference<Object?>>> addProduit(String nom,String description,String uniteMesure,double prixUnitaire,String photo,int userId,int categorieProduitId) async{
  return Produits.add({
    'nom':nom,
    'description':description,
    'uniteMesure':uniteMesure,
    'prixUnitaire':prixUnitaire,
    "timestamp":Timestamp.now(),
    'userId':userId,
    'categorieProduitId':categorieProduitId,
  });
}

// recuperer note bdd
/*Stream<QuerySnapshot> getProduits(){
  final produitStream = Produits.orderBy
}*/

// ajouter categorieCommerce bdd 
//recuperer la collectio categorieCommerce
final CollectionReference categorieCommerce = FirebaseFirestore.instance.collection('categorieCommerce');
//ajouter un nouveau categorieCommerce
Future<Future<DocumentReference<Object?>>> addCategorie(String codcat,String libcat) async{
  return categorieCommerce.add({
    'codcat':codcat,
    'libcat':libcat,
    'timestamp': Timestamp.now()
    
  });
}


// recuperer categorie commerce bdd
Stream<QuerySnapshot> getCategorieCommerce(){
  final commerceStream = categorieCommerce.orderBy('timestamp',descending: true).snapshots();
  return commerceStream;
}

// ajouter categorieproduit bdd 
//recuperer la collectio categorieproduit
final CollectionReference categorieProduit = FirebaseFirestore.instance.collection('categorieProduit');
//ajouter un nouveau categorieCommerce
Future<Future<DocumentReference<Object?>>> addCategorieProduit(String categorieCommerceId, String libCommerce, String codcat,String libcat,String description,String photo) async{
  return categorieProduit.add({
    'categorieCommerceId':categorieCommerceId,
    'libCommerce':libCommerce,
    'codcat':codcat,
    'libcat':libcat,
    'description':description,
    'photo':photo,
    'timestamp': Timestamp.now()
    
  });
}


// recuperer categorie commerce bdd
Stream<QuerySnapshot> getCategorieProduit(){
  final produitStream = categorieProduit.orderBy('timestamp',descending: true).snapshots();
  return produitStream;
}

// ajouter stand bdd 
//recuperer la collectio stand 
final CollectionReference stands = FirebaseFirestore.instance.collection('stands');
//ajouter un nouveau categorieCommerce
Future<Future<DocumentReference<Object?>>> addStand(String categorieId, String emplacement,String superficie,String numeroStand, {String disponibilite = "Immediate"}) async{
  return stands.add({
    'categorieId':categorieId,
    'emplacement':emplacement,
    'superficie':superficie,
    'numeroStand':numeroStand,
    'disponibilite':disponibilite,
    'timestamp': Timestamp.now()
    
  });
}
// recuperer stand de categorie 
Stream<QuerySnapshot> getStandsWithCategorie() {
  final standsStream = stands.orderBy('timestamp', descending: true).snapshots();
  return standsStream;
}

// update
//Future<void> update
 }