import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final String price;
  int quantity;

  CartItem({
    required this.title,
    required this.price,
    this.quantity = 1,
  });
}

class CartPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final VoidCallback onResetCart;
  final Function(CartItem) onRemoveItem;

  CartPage({
    required this.cartItems,
    required this.onResetCart,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    double totalAmount = cartItems.fold(0, (sum, item) {
      return sum + (int.parse(item.price.replaceAll(RegExp(r'\D'), '')) * item.quantity);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Panier', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF156651),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text('${item.price} x ${item.quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${int.parse(item.price.replaceAll(RegExp(r'\D'), '')) * item.quantity} CFA'),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => onRemoveItem(item),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: $totalAmount CFA',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          if (totalAmount > 0)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Action pour commander
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF156651),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Commander',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: onResetCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Réinitialiser le panier',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}