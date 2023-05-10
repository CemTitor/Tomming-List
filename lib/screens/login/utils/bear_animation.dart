import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:shopping_cart_tom/providers/password_visible_provider.dart';

class BearAnimation extends StatelessWidget {
  const BearAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordVisible = context.watch<PasswordVisibleProvider>().passwordVisible;
    final isChecking = context.watch<PasswordVisibleProvider>().isChecking;
    return SizedBox(
      width: 300,
      height: 200,
      child: RiveAnimation.asset(
        'assets/login_bear_transparent.riv',
        animations: passwordVisible ? ['Hands_up'] : isChecking ? ['Look_down_left'] : ['hands_down'],
        fit: BoxFit.cover,
      ),
    );
  }
}