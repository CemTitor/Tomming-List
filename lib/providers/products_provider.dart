import 'package:flutter/material.dart';
import 'package:shopping_cart_tom/models/product.dart';

import '../services/products_service.dart';

enum FilterOptions { LowestPrice, HighestPrice }

class ProductsProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product> _products = [];

  Future<void> fetchProducts() async {
    _products = await _productService.fetchProducts();
    notifyListeners();
  }

  List<Product> get products {
    return [..._products];
  }

  Product findById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }
  Future<Product> getProductById(String id) async {
    return await _productService.getProductById(id);
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
