import 'package:flutter/foundation.dart';
import 'package:shopping_cart_tom/models/coupon.dart';
import 'package:shopping_cart_tom/services/coupon_service.dart';

class CouponsProvider with ChangeNotifier {
  final CouponService _couponService = CouponService();

  List<Coupon> _coupons = [];

  List<Coupon> get coupons {
    return [..._coupons];
  }

  Future<void> fetchAndSetCoupons() async {
    try {
      final fetchedCoupons = await _couponService.getAllCoupons();
      _coupons = fetchedCoupons;
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print("An error occurred while fetching coupons: $error");
      }
      rethrow;
    }
  }

  Future<Coupon?> applyCoupon(String couponId) async {
    try {
      final appliedCoupon = await _couponService.applyCoupon(couponId);
      return appliedCoupon;
    } catch (error) {
      if (kDebugMode) {
        print("An error occurred while applying the coupon: $error");
      }
      rethrow;
    }
  }

}
