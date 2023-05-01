import 'package:flutter/foundation.dart';
import 'package:shopping_cart_tom/models/product.dart';
import 'package:shopping_cart_tom/models/cart_item.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalPrice {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    try {
      if (_items.containsKey(product.id)) {
        _items.update(
          product.id,
              (existingItem) => CartItem(
            id: existingItem.id,
            productId: existingItem.productId,
            title: existingItem.title,
            quantity: existingItem.quantity + 1,
            price: existingItem.price,
          ),
        );
      } else {
        _items.putIfAbsent(
          product.id,
              () => CartItem(
            id: DateTime.now().toString(),
            productId: product.id,
            title: product.name,
            quantity: 1,
            price: product.price,
          ),
        );
      }
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print("An error occurred while adding the product to the cart: $error");
      }
      rethrow;
    }
  }

  void removeItem(String productId) {
    try {
      _items.remove(productId);
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print("An error occurred while removing the product from the cart: $error");
      }
      rethrow;
    }
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
