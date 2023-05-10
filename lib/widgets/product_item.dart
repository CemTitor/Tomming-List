import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_tom/models/product.dart';
import 'package:shopping_cart_tom/providers/cart_provider.dart';
import 'package:shopping_cart_tom/screens/product_details_screen.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem(this.product, {super.key});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  // int _quantity = 0;
  int get _quantity {
    return Provider.of<CartProvider>(context, listen: false)
        .getItemQuantity(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.routeName,
            arguments: widget.product.id);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _quantity > 0 ?  Theme.of(context).primaryColor : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: _quantity > 0 ? Theme.of(context).primaryColor : Theme.of(context).shadowColor,
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    widget.product.imageUrl!,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.product.name,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '\$${widget.product.price}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: _quantity == 0
                    ? IconButton(
                  icon: Icon(Icons.add, color: Colors.black),
                  onPressed: () async{
                      await cartProvider.addItem(widget.product);
                      setState(() {});
                  },
                )
                    : Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () async{
                          await cartProvider.addItem(widget.product);
                          setState(()  {});
                        },
                      ),
                      Text(
                        '$_quantity',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            cartProvider.removeItemByQuantity(widget.product.id);

                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
