import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cart_tom/constants/global_constants.dart';

class AuthenticationService with ChangeNotifier {
  String? userUid;
  String? get getUserid => userUid;
  String? accessToken;
  String? get getAccessToken => accessToken;

  static bool successLogin = false;
  static bool successSignup = false;
  static bool verifiedMail = false;

  // Singleton implementation
  static AuthenticationService? _instance;
  AuthenticationService._privateConstructor();

  // Singleton getter
  static AuthenticationService get instance {
    _instance ??= AuthenticationService._privateConstructor();
    return _instance!;
  }

  Future logIntoAccount(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
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
        print('access Token: $accessToken');
        print('userId: $userUid');
        successLogin = true;

        // Save user login state
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', true);

        // Save accessToken and userUid
        await saveUserCredentials();

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
        Uri.parse('$baseUrl/register'),
        headers: {
          'accept': '*/*',
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
        print('Signed up successfully.');
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

  Future<void> logOut() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
        },
      );

      ///todo:for now we dont have endpoint so, we will use this
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', false);

      if (response.statusCode == 200) {
        print('Logged out successfully.');

        // Clear user login state
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', false);

        // Clear userUid and accessToken
        userUid = null;
        accessToken = null;

        successLogin = false;

        notifyListeners();
      } else {
        print('Failed to log out.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> saveUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken!);
    await prefs.setString('userUid', userUid!);
  }

  Future<void> loadUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken');
    userUid = prefs.getString('userUid');
  }

}
