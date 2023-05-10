import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/coupons_provider.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final couponsProvider = Provider.of<CouponsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Coupons')),
      body: FutureBuilder(
        future: couponsProvider.fetchAndSetCoupons(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return const Center(child: Text('An error occurred!'));
            } else {
              return Consumer<CouponsProvider>(
                builder: (ctx, couponsProvider, _) {
                  final coupons = couponsProvider.coupons;
                  return ListView.builder(
                    itemCount: coupons.length,
                    itemBuilder: (ctx, i) => Consumer<CartProvider>(
                      builder: (ctx, cartProvider, _) {
                        bool isSelected =
                            cartProvider.selectedCoupon?.id == coupons[i].id;
                        return ListTile(
                          tileColor: isSelected ? Colors.blue : null,
                          title: Text('Coupon ${coupons[i].id}'),
                          subtitle: Text(
                              '${coupons[i].discountType}: ${coupons[i].value}%'),
                          onTap: () {
                            cartProvider.setSelectedCoupon(
                                isSelected ? null : coupons[i]);
                          },
                        );
                      },
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
