import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_cart_tom/models/coupon.dart';

class CouponService {

  final String baseUrl =
      'https://4c87-31-206-104-209.ngrok-free.app/api/CouponContoller';
  final String userId = '6459066cac3227b6ca96a7ec';
  final String bearerToken =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI2NDU5MDY2Y2FjMzIyN2I2Y2E5NmE3ZWMiLCJlbWFpbCI6ImNteWxtekBnbWFpbC5jb20iLCJuYmYiOjE2ODM2Nzc3MzQsImV4cCI6MTY4MzY4MTMzNCwiaWF0IjoxNjgzNjc3NzM0LCJpc3MiOiJ3d3cudG9taWlzc3Vlci5jb20iLCJhdWQiOiJ3d3cudG9taS5jb20ifQ.lQ4JYLO3X7yDdtO0nl9mb39DPiazscUkhFUI8l_KoEg';

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
        'userId': userId,
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
