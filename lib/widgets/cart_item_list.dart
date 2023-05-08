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
              child: const Icon(Icons.delete, size: 24),
            ),
            onDismissed: (direction) {
              cartProvider.removeItem(cartItemId);
            },
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage(cartItem?.imageUrl ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text('${cartItem?.title}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${cartItem?.price}',style: Theme.of(context).textTheme.bodyLarge?.copyWith(color:  Theme.of(context).primaryColor),),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove,),
                    onPressed: () {
                      cartProvider.removeItemByQuantity(cartItemId);
                    },
                  ),
                  Text(
                    '${cartItem?.quantity}',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.add,),
                    onPressed: () {
                      // cartProvider.addItem(cartItem?.product, 1);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
