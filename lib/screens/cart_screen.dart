import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_tom/providers/cart_provider.dart';
import 'package:shopping_cart_tom/widgets/cart_item_list.dart';

class CartScreen extends StatelessWidget {

  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      body: Column(
        children: <Widget>[
          const CartItemList(),
          const SizedBox(height: 10),
          Text('Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}'),
          ElevatedButton(
            onPressed: () {
              cartProvider.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cart cleared!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Clear Cart'),
          ),
        ],
      ),
    );
  }
}