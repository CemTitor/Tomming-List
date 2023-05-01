import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_tom/providers/products_provider.dart';
import 'package:shopping_cart_tom/constants/routes_consts.dart';
import 'package:shopping_cart_tom/providers/cart_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = productDetailScreenRoute;
  const ProductDetailsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final product = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            product.imageUrl != null
                ? Image.network(product.imageUrl!)
                : const SizedBox.shrink(),
            const SizedBox(height: 10),
            Text(product.description),
            const SizedBox(height: 10),
            Text('\$${product.price.toStringAsFixed(2)}'),
            ElevatedButton.icon(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).addItem(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Product successfully added to cart!'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        // Provider.of<CartProvider>(context, listen: false).removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
