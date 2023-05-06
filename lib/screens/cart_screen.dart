import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_list.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;

    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: Column(
        children: <Widget>[
          CartItemList(),
          SizedBox(height: 10),
          cartProvider.selectedCoupon != null
              ? Text(
              'Applied Coupon: ${cartProvider.selectedCoupon!.id} (${cartProvider.selectedCoupon!.discountType}: ${cartProvider.selectedCoupon!.value}%)')
              : Text('No Coupon Applied'),
          SizedBox(height: 10),
          Text('Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}