import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_cart_tom/models/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://6180-31-206-104-209.ngrok-free.app/api/Product/get-all-products'),
      headers: {'accept': '*/*'},
    );
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products from API');
    }
  }
  

}
