import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_tom/providers/products_provider.dart';
import 'package:shopping_cart_tom/constants/routes_consts.dart';

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
            Image.network(product.imageUrl),
            SizedBox(height: 10),
            Text(product.description),
            SizedBox(height: 10),
            Text('\$${product.price.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
