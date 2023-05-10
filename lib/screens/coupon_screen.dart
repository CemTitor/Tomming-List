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
      appBar: AppBar(
        title: Text('Coupons', style: TextStyle(color: Colors.white)),
      ),
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
                            cartProvider.selectedCoupon?.value == coupons[i].value;
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          child: ListTile(
                            tileColor: isSelected
                                ? Theme.of(context).primaryColor.withOpacity(0.3)
                                : null,
                            title: Text(
                              'Coupon ${i + 1} ${coupons[i].id}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${coupons[i].discountType}: ${coupons[i].value}' +
                                  (coupons[i].discountType == 'Ratio' ? '%' : ''),
                            ),
                            trailing: isSelected
                                ? Icon(
                              Icons.check_circle,
                              color: Theme.of(context).primaryColor,
                            )
                                : null,
                            onTap: () {
                              cartProvider.setSelectedCoupon(
                                  isSelected ? null : coupons[i]);
                            },
                          ),
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
