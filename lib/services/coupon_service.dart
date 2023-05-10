import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_cart_tom/constants/global_constants.dart';
import 'package:shopping_cart_tom/models/coupon.dart';

class CouponService extends ChangeNotifier {

  Future<List<Coupon>> getAllCoupons() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get-all-coupons'),
      headers: {
        'accept': '*/*',
        'Authorization': bearerToken,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((coupon) => Coupon.fromJson(coupon)).toList();
    } else {
      throw Exception('Failed to load coupons');
    }
  }

  Future<Coupon?> applyCoupon(String couponId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/apply-coupon'),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': bearerToken,

      },
      body: jsonEncode({
        'couponId': couponId,
      }),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return Coupon.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to apply coupon');
    }
  }
}
