import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/coupons_provider.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final couponsProvider = Provider.of<CouponsProvider>(context);
    final coupons = couponsProvider.coupons;

    return Scaffold(
    appBar: AppBar(title: const Text('Coupons')),
    body: ListView.builder(
      itemCount: coupons.length,
      itemBuilder: (ctx, i) => Consumer<CartProvider>(
        builder: (ctx, cartProvider, _) {
          bool isSelected = cartProvider.selectedCoupon?.id == coupons[i].id;
          return ListTile(
            tileColor: isSelected ? Colors.blue : null,
            title: Text('Coupon ${coupons[i].id}'),
            subtitle: Text('${coupons[i].discountType}: ${coupons[i].value}%'),
            onTap: () {
              cartProvider.setSelectedCoupon(isSelected ? null : coupons[i]);
            },
          );
        },
      ),
    ),
    );
  }
}
