import 'package:flutter/material.dart';
import 'package:chrip_aid/common/styles/styles.dart';

class SnackBarUtil {
  static GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  static void showError(String message) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(drawSnackBar(message, CustomColor.pointColor));
  }

  static void showMessage(String message) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(drawSnackBar(message, CustomColor.subColor));
  }

  static void showSuccess(String message) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(drawSnackBar(message, CustomColor.mainColor));
  }

  static SnackBar drawSnackBar(String message, Color color) {
    return SnackBar(
      backgroundColor: color,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, textAlign: TextAlign.center, softWrap: false),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(
        vertical: kPaddingMiddleSize,
        horizontal: kPaddingSmallSize,
      ),
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
