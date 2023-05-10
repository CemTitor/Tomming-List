import 'package:shopping_cart_tom/services/auth_service.dart';

const String baseUrl = 'https://871c-31-206-104-209.ngrok-free.app';
AuthenticationService authService = AuthenticationService.instance;
String bearerToken = 'Bearer ${authService.getAccessToken}';
