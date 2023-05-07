import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_tom/providers/products_provider.dart';
import 'package:shopping_cart_tom/widgets/product_item.dart';

import '../providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    var products = productsProvider.searchProducts(_searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text('Lowest Price'),
                            onTap: () {
                              setState(() {
                                products = productsProvider.filterProducts(FilterOptions.LowestPrice);
                              });
                              Navigator.of(ctx).pop();
                            },

                          ),
                          ListTile(
                            title: const Text('Highest Price'),
                            onTap: () {
                              setState(() {
                                products = productsProvider.filterProducts(FilterOptions.HighestPrice);
                              });
                              Navigator.of(ctx).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),

          Row(
            children: [
              Text('Dark Mode'),
              Switch(
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  themeProvider.toggleThemeMode();
                },
              ),
            ],
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        itemBuilder: (ctx, i) => ProductItem(products[i]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // mainAxisExtent: 250,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
      ),
    );
  }
}
