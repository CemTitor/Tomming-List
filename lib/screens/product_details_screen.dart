import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_tom/providers/products_provider.dart';
import 'package:shopping_cart_tom/constants/routes_consts.dart';
import 'package:shopping_cart_tom/providers/cart_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = productDetailScreenRoute;

  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final product = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);
    final cartProvider = Provider.of<CartProvider>(context);
    final int _quantity = cartProvider.getItemQuantity(productId);

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pushNamed(context, MainScreen.routeName);
        //   },
        // ),
        elevation: 0,
        actions: [
          IconButton(
            color: _isFavorite ? Colors.red : Colors.black,
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              product.imageUrl != null
                  ? Center(
                child: Image(
                  image: AssetImage(product.imageUrl!),
                ),
              )
                  : const SizedBox.shrink(),
              const SizedBox(height: 10),
              Text(product.name,
                  style: Theme.of(context).textTheme.headlineLarge),
              SizedBox(height: 10),
              const Placeholder(
                fallbackHeight: 70,
              ),
              SizedBox(height: 10),
              Text("Details", style: Theme.of(context).textTheme.headlineSmall),
              Text(product.description),
              Divider(
                thickness: 1,
              ),
              const SizedBox(height: 20),
              if (_quantity == 0)
                FilledButton(
                  onPressed: () {
                    cartProvider.addItem(product, 1);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                        const Text('Product successfully added to cart!'),
                        duration: const Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            cartProvider.removeItem(product.id);
                          },
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15),
                    child: Text(
                      'Add to Cart',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Price",
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                              color:
                              Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              cartProvider.removeItemByQuantity(productId, 1);
                            });
                          },
                        ),
                        Text(
                          '$_quantity',
                          style: TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              cartProvider.addItem(product, 1);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

