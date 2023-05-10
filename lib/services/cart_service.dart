import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_cart_tom/constants/global_constants.dart';
import 'package:shopping_cart_tom/models/cart_item.dart';

class CartService {

  // final AuthService _authService = AuthService();
  // String get userId => _authService.getUserid!;
  // String get bearerToken => 'Bearer ${_authService.getAccessToken}';

  final String baseUrl =
      'https://4c87-31-206-104-209.ngrok-free.app/api/ShoppingCart';
  final String userId = '6459066cac3227b6ca96a7ec';
  final String bearerToken =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI2NDU5MDY2Y2FjMzIyN2I2Y2E5NmE3ZWMiLCJlbWFpbCI6ImNteWxtekBnbWFpbC5jb20iLCJuYmYiOjE2ODM2Nzc3MzQsImV4cCI6MTY4MzY4MTMzNCwiaWF0IjoxNjgzNjc3NzM0LCJpc3MiOiJ3d3cudG9taWlzc3Vlci5jb20iLCJhdWQiOiJ3d3cudG9taS5jb20ifQ.lQ4JYLO3X7yDdtO0nl9mb39DPiazscUkhFUI8l_KoEg';

  Future<void> addItemToShoppingCart(String productId) async {
    final response = await http.post(
      Uri.parse(
          '$baseUrl/add-item-to-shopping-cart?productId=$productId'),
      headers: {
        'accept': '*/*',
        'Authorization': bearerToken,
      },
    );
    if (response.statusCode == 200) {
      print('Item added to shopping cart backend');
    } else {
      throw Exception('Failed to add item to shopping cart');
    }
  }

  Future<List<CartItem>> getAllShoppingCartItems() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get-all-shopping-cart-items'),
      headers: {
        'accept': '*/*',
        'Authorization': bearerToken,
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> items = responseData['items'];
      return items.map((item) => CartItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to get all shopping cart items');
    }
  }

  Future<void> removeItemByQuantity(String productId) async {
    final response = await http.delete(
      Uri.parse(
          '$baseUrl/decrease-item-amount-in-shopping-cart?productId=$productId'),
      headers: {
        'accept': '*/*',
        'Authorization': bearerToken,
      },
    );

    if (response.statusCode == 200) {
      print('Item removed from shopping cart backend');
    } else {
      throw Exception('Failed to remove item from shopping cart');
    }
  }

  Future<void> removeItem(String productId) async {
    final response = await http.delete(
      Uri.parse(
          '$baseUrl/remove-item-from-shopping-cart-compeletely?productId=$productId'),
      headers: {
        'accept': '*/*',
        'Authorization': bearerToken,
      },
    );

    if (response.statusCode == 200) {
      print('Item completely removed from shopping cart backend');
    } else {
      throw Exception('Failed to completely remove item from shopping cart');
    }
  }

  Future<void> clearShoppingCart() async {
    final response = await http.delete(
      Uri.parse(
          '$baseUrl/clear-shopping-cart'),
      headers: {
        'accept': '*/*',
        'Authorization': bearerToken,
      },
    );

    if (response.statusCode == 200) {
      print('All items removed from shopping cart backend');
    } else {
      throw Exception('Failed to remove all items from shopping cart');
    }
  }
}
