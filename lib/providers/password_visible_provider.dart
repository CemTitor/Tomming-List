
import 'package:flutter/cupertino.dart';

class PasswordVisibleProvider extends ChangeNotifier {
  bool _passwordVisible = false;
  bool _isChecking = false;

  bool get passwordVisible => _passwordVisible;
  bool get isChecking => _isChecking;

  void updatePasswordVisible(bool visible) {
    _passwordVisible = visible;
    notifyListeners();
  }

  void updateUsername(bool checking) {
    _isChecking = checking;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }
}
