import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_tom/providers/cart_provider.dart';

class CartItemList extends StatelessWidget {
  const CartItemList({super.key});

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
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white, size: 36),
            ),
            onDismissed: (direction) {
              cartProvider.removeItem(cartItemId);
            },
            child: ListTile(
              leading: const CircleAvatar(
                // backgroundImage: NetworkImage(cartItems[i]?.imageUrl),
              ),
              title: Text('${cartItem?.title}'),
              subtitle: Text('Quantity: ${cartItem?.quantity}'),
              trailing: Text('\$${(cartItem?.price ?? 0) * (cartItem?.quantity ?? 0)} '),
            ),
          );
        },
      ),
    );
  }
}
