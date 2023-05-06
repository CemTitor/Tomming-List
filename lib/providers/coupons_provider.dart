import 'package:flutter/material.dart';
import 'package:shopping_cart_tom/models/coupon.dart';

class CouponsProvider with ChangeNotifier {
  final List<Coupon> _coupons = [
    Coupon(id: 'coupon1', discountType: 'Amount', value: 50),
    Coupon(id: 'coupon2', discountType: 'Ratio', value: 10),
    Coupon(id: 'coupon3', discountType: 'Ratio', value: 5),
  ];

  List<Coupon> get coupons {
    return [..._coupons];
  }

}
