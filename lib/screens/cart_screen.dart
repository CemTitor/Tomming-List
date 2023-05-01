import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {

  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: Column(
        children: <Widget>[
          CartItemList(),
          SizedBox(height: 10),
          Text('Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}'),
          ElevatedButton(
            onPressed: () {
              cartProvider.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Cart cleared!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text('Clear Cart'),
          ),
        ],
      ),
    );
  }
}


class CartItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;

    return Expanded(
      child: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (ctx, i) {
          final cartItemId = cartItems.keys.toList()[i];
          final cartItem = cartItems[cartItemId];

          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white, size: 36),
            ),
            onDismissed: (direction) {
              cartProvider.removeItem(cartItemId);
            },
            child: ListTile(
              leading: CircleAvatar(
                // backgroundImage: NetworkImage(cartItems[i]?.imageUrl),
              ),
              title: Text('${cartItem?.title}'),
              subtitle: Text('Quantity: ${cartItem?.quantity}'),
              trailing: Text('\$${(cartItem?.price ?? 0).toStringAsFixed(2) * (cartItem?.quantity ?? 0)} '),

            ),
          );
        },
      ),
    );
  }
}

