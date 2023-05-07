import 'package:flutter/foundation.dart';
import 'package:shopping_cart_tom/models/coupon.dart';
import 'package:shopping_cart_tom/models/product.dart';
import 'package:shopping_cart_tom/models/cart_item.dart';

class CartProvider with ChangeNotifier {

  Map<String, CartItem> _items = {};
  Coupon? _selectedCoupon;

  Map<String, CartItem> get items {
    return {..._items};
  }
  int get productCount {
    return _items.length;
  }

  int getItemQuantity(String productId) {
    if (_items.containsKey(productId)) {
      return _items[productId]!.quantity;
    }
    return 0;
  }

  int get itemCount{
    int total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity;
    });
    return total;
  }
  Coupon? get selectedCoupon => _selectedCoupon;

  double get totalPrice {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    if (_selectedCoupon != null) {
      if (_selectedCoupon!.discountType == 'Ratio') {
        total = total * (1 - _selectedCoupon!.value / 100);
      } else if (_selectedCoupon!.discountType == 'Amount') {
        total -= _selectedCoupon!.value;
        if (total < 0) total = 0;
      }
    }
    return total;
  }

  void setSelectedCoupon(Coupon? coupon) {
    _selectedCoupon = coupon;
    notifyListeners();
  }

  void addItem(Product product, int quantity) {
    try {
      if (_items.containsKey(product.id)) {
        _items.update(
          product.id,
              (existingItem) => CartItem(
            id: existingItem.id,
            productId: existingItem.productId,
            title: existingItem.title,
            quantity: existingItem.quantity + quantity,
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
            quantity: quantity,
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
