import 'package:cloud_firestore/cloud_firestore.dart';

class Firestoreservices {

//recuperer la collectio produit
final CollectionReference produits = FirebaseFirestore.instance.collection('produits');
//ajouter un nouveau produit
Future<DocumentReference<Object?>>  addProduit(String categorieProduitId, String categorieProduitLibelle, String nom,String description,String idMesure, String uniteMesure,double prixUnitaire,String photo,String userId) async{
  return produits.add({
    'categorieProduitId':categorieProduitId,
    'categorieProduitLibelle':categorieProduitLibelle,
    'nom':nom,
    'description':description,
    'prixUnitaire':prixUnitaire,
    'idMesure':idMesure,
    'uniteMesure':uniteMesure,
    'photo':photo,
    'userId':userId,
    "timestamp":Timestamp.now(),
  });
}

// recuperer produit bdd
Stream<QuerySnapshot> getProduits(){
  final produitStream = produits.orderBy('timestamp',descending: true).snapshots();
  return produitStream;
}

// ajouter categorieCommerce bdd 
//recuperer la collectio categorieCommerce
final CollectionReference categorieCommerce = FirebaseFirestore.instance.collection('categorieCommerce');
//ajouter un nouveau categorieCommerce
Future<DocumentReference<Object?>> addCategorie(String codcat,String libcat) async{
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
Future<DocumentReference<Object?>>  addCategorieProduit(String categorieCommerceId, String libCommerce, String codcat,String libcat,String description,String photo) async{
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
Future<DocumentReference<Object?>> addStand(String categorieId, String emplacement,String superficie,String numeroStand, {String disponibilite = "Immediate"}) async{
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
//recuperer donnees user
Future<DocumentSnapshot?> getUserData(String userId) async {
  try {
    return await FirebaseFirestore.instance.collection('users').doc(userId).get();
  } catch (e) {
    print("Erreur lors de la récupération des données utilisateur: $e");
    return null;
  }
}
// ajouter mesure bdd
final CollectionReference uniteMesure = FirebaseFirestore.instance.collection('uniteMesure');
//ajouter un nouveau categorieCommerce
Future<DocumentReference<Object?>>  adduniteMesure(String libelle) async{
  return uniteMesure.add({
    'libelle':libelle,
    'timestamp': Timestamp.now()
    
  });
}
// recup unite de mesure
Stream<QuerySnapshot> getUniteMesure() {
  final standsStream = uniteMesure.orderBy('timestamp', descending: true).snapshots();
  return standsStream;
}
// update
Future<void> updateProduit(String produitId,String newCategorieProduitId, String newCategorieProduitLibelle, String newNom,String newDescription,String newIdMesure, String newUniteMesure,double newPrixUnitaire,String newPhoto)async{
  return produits.doc(produitId).update({
    'CategorieProduitId':newCategorieProduitId,
    'CategorieProduitLibelle':newCategorieProduitLibelle,
    'nom':newNom,
    'description':newDescription,
    'idMesure':newIdMesure,
    'uniteMesure':newUniteMesure,
    'prixUnitaire':newPrixUnitaire,
    'photo':newPhoto,
    'timestamp':Timestamp.now()

  }
    );
}
//delete
Future<void> deleteProduit(String idProduit)async{
  return produits.doc(idProduit).delete();
}

// ajouter commande bdd
final CollectionReference commandes = FirebaseFirestore.instance.collection('commandes');
//ajouter une commande
Future<DocumentReference<Object?>>  addCommande(String userId,String username,String vendeuseId,String vendeuseName,String produit,double prix,{String etat = 'lancer'}) async{
  return commandes.add({
    'userId':userId,
    'userName':username,
    'vendeuseId':vendeuseId,
    'vendeuseName':vendeuseName,
    'produit':produit,
    'prix':prix,
    'etat':etat,
    'timestamp': Timestamp.now()
    
  });
}
 }