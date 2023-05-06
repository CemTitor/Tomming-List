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
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final product = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);

    return Scaffold(
      appBar: AppBar(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Material(
                      color: Theme.of(context).colorScheme.primary,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (_quantity > 1) _quantity--;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    color: Theme.of(context).colorScheme.primary,
                    child: Text(
                      '$_quantity',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Material(
                      color: Theme.of(context).colorScheme.primary,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )

              ,
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
                                color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),

                  FilledButton(
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addItem(product, _quantity);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              const Text('Product successfully added to cart!'),
                          duration: const Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .removeItem(product.id);
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
