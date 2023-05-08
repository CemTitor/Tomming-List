import 'dart:convert';
import 'package:http/http.dart' as http;

class CartService {
  Future<void> addItemToShoppingCart(String userId, String productId) async {
    final response = await http.post(
      Uri.parse('https://6180-31-206-104-209.ngrok-free.app/api/ShoppingCart/add-item-to-shopping-cart'),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userId': userId,
        'productId': productId,
      }),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode == 200) {
      print('Item added to shopping cart backend');

    } else {
      throw Exception('Failed to add item to shopping cart');
    }
  }
}
