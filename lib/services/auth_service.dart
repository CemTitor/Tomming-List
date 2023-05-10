import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthenticationService with ChangeNotifier {
  String? userUid;
  String? get getUserid => userUid;
  String? accessToken;
  String? get getAccessToken => accessToken;

  static bool successLogin = false;
  static bool successSignup = false;
  static bool verifiedMail = false;

  final String baseUrl = 'https://4c87-31-206-104-209.ngrok-free.app';

  Future logIntoAccount(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/Auth/login'),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          // 'email': email,
          // 'password': password,
          'email': 'cmylmz@gmail.com',
          'password': 'CEmcem.90',
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        accessToken = responseBody['data']['token'];
        userUid = responseBody['data']['userId'];
        print(' acces token: $accessToken');
        print( 'user id: $userUid');
        successLogin = true;
        notifyListeners();
      } else {
        successLogin = false;
        print('Failed to log in.');
      }
    } catch (e) {
      successLogin = false;
      print('Error: $e');
    }
  }

  Future createAccount(String firstName, String lastName, String userName,
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/Auth/register'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'userName': userName,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        userUid = responseBody['data']['userId'];
        print(userUid);
        successSignup = true;
        notifyListeners();
      } else {
        successSignup = false;
        print('Failed to sign up.');
      }
    } catch (e) {
      successSignup = false;
      print('Error: $e');
    }
  }

}
