import 'package:flutter/material.dart';
import 'package:shopping_cart_tom/constants/item_consts.dart';
import 'package:shopping_cart_tom/models/product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _products = productList;

  List<Product> get products {
    return [..._products];
  }

  Product findById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  List<Product> searchProducts(String query) {
    if (query.isEmpty) {
      return products;
    } else {
      return _products
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  List<Product> filterProducts(FilterOptions filterOption) {
    List<Product> filteredProducts = products;
    switch (filterOption) {
      case FilterOptions.LowestPrice:
        filteredProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case FilterOptions.HighestPrice:
        filteredProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
    }
    return filteredProducts;
  }
}
