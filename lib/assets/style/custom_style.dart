import 'package:flutter/material.dart';

class CustomStyle {
  static double maxScreenSize = 1920;
  static const Color lightHighFontColor = Color(0xFF4D4D4D);
  static const Color lightSoftFontColor = Color(0xFF797979);
  static const Color lightBackgroundColor = Color(0xFFF5EFE7);
  static const Color lightBorderLayoutColor = Color(0xFFc2bdb5);
  static const Color lightButtonAreaColor = Color(0xFFebe5dd);
  static const Color lightButtonHoverColor = Color(0xFFC7B299);
  static const Color lightSoftContainerColor = Color(0xFFebe5dd);
  // static const Color lightButtonColor = Color(0xFF483507);
  // static const Color lightStyleButtonColor = Color(0xFFc2bdb5);

  static const Color darkHighFontColor = Color(0xFFFFFFFF);
  static const Color darkSoftFontColor = Color(0xFFe0e0e0);
  static const Color darkBackgroundColor = Color(0xFF0F1C2E);
  static const Color darkBorderLayoutColor = Color(0xFF374357);
  static const Color darkButtonAreaColor = Color(0xFF1f2b3e);
  static const Color darkButtonHoverColor = Color(0xFF1F3A5F);
  static const Color darkSoftContainerColor = Color(0xFF1f2b3e);
  // static const Color darkButtonColor = Color(0xFFcee8ff);
  // static const Color darkStyleButtonColor = Color(0xFF374357);

  static const String urlIcon = "lib/assets/icons";
  static const String urlImage = "lib/assets/images";

  static double maxWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double maxHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static bool conditionDevice(BuildContext context) {
    bool result = maxWidth(context) <= 800;
    return result;
  }
}
