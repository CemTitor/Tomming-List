import 'package:flutter/material.dart';
import 'package:shopping_cart_tom/providers/products_provider.dart';
import 'package:shopping_cart_tom/services/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ProductsProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Shopping Cart',
          home: HomeScreen(),
        ),
    );
  }
}


