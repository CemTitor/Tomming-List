import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_cart_tom/models/product.dart';
import 'package:shopping_cart_tom/constants/global_constants.dart';

class ProductService {


  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get-all-products'),
      headers: {'accept': '*/*'},
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products from API');
    }
  }

  Future<Product> getProductById(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/get-product-by-id?id=$id'),
      headers: {'accept': '*/*'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return Product.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load product by ID from API');
    }
  }
  

}
