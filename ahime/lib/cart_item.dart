class CartItem {
  final String title; // Titre de l'article
  final String price; // Prix de l'article
  int quantity; // Quantité de l'article dans le panier

  CartItem({
    required this.title, // Titre obligatoire
    required this.price, // Prix obligatoire
    this.quantity = 1, // Quantité par défaut à 1
  });

  // Optionnel : Vous pouvez ajouter une méthode pour afficher les détails de l'article
  @override
  String toString() {
    return 'CartItem(title: $title, price: $price, quantity: $quantity)';
  }
}
