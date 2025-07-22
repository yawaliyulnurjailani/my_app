import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarComp {
  static void snackDefault({
    int duration = 3,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    Icon? icon,
    EdgeInsets padding =
        const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    required String title,
    required String message,
    Color backgroundColor = Colors.black87,
    Color titleColor = Colors.white,
    Color messageColor = Colors.white70,
    forwardAnimationCurve = Curves.easeOutBack,
  }) {
    Get.snackbar(
      '',
      '',
      maxWidth: 1000,
      duration: Duration(seconds: duration),
      snackStyle: SnackStyle.FLOATING,
      snackPosition: snackPosition,
      isDismissible: true,
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      borderRadius: 10,
      barBlur: 40.0,
      icon: icon,
      padding: padding,
      titleText: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: messageColor,
          fontSize: 16,
        ),
      ),
      forwardAnimationCurve: forwardAnimationCurve,
    );
  }
}
