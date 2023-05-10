import 'package:flutter/material.dart';

class CustomSnackBar {
  CustomSnackBar(
    BuildContext context,
    Widget content, {
    SnackBarAction? snackBarAction,
  }) {
    final SnackBar snackBar = SnackBar(
        action: snackBarAction,
        content: content,
        behavior: SnackBarBehavior.floating,);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
