class Produit {
  final String id;
  final String categorieProduitId;
  final String categorieProduitLibelle;
  final String nom;
  final String description;
  final String idMesure;
  final String uniteMesure;
  final double prixUnitaire;
  final String photo;
  final String userId;

  Produit({
    required this.id,
    required this.categorieProduitId,
    required this.categorieProduitLibelle,
    required this.nom,
    required this.description,
    required this.idMesure,
    required this.uniteMesure,
    required this.prixUnitaire,
    required this.photo,
    required this.userId,
  });
}