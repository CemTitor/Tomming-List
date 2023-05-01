import 'package:flutter/material.dart';
import 'package:shopping_cart_tom/constants.dart';
import 'package:shopping_cart_tom/models/product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _products = productList;

  List<Product> get products {
    return [..._products];
  }

  Product findById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

}
