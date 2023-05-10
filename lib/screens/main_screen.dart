import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_tom/constants/routes_consts.dart';
import 'package:shopping_cart_tom/providers/cart_provider.dart';
import 'package:shopping_cart_tom/screens/cart_screen.dart';
import 'package:shopping_cart_tom/screens/home_screen.dart';
import 'package:shopping_cart_tom/screens/coupon_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = mainScreenRoute;

  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const CouponsScreen(),
    const CartScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: _selectedIndex != 2
          ? Consumer<CartProvider>(
              builder: (context, cart, child) {
                return cart.itemCount > 0
                    ? FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 2;
                          });
                        },
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.shopping_cart),
                            SizedBox(width: 5),
                            Text(
                              cart.itemCount.toString(),style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink();
              },
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Coupons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
