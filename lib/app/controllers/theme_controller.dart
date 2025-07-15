import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../assets/style/custom_style.dart';

class ThemeController extends GetxController {
  var setThemeData = ThemeData().obs;
  ThemeData get getThemeData => setThemeData.value;

  var setIsDarkMode = false.obs;
  bool get getIsDarkMode => setIsDarkMode.value;

  var setHighFontColor = CustomStyle.lightHighFontColor.obs;
  Color get getHighFontColor => setHighFontColor.value;

  var setSoftFontColor = CustomStyle.lightSoftFontColor.obs;
  Color get getSoftFontColor => setSoftFontColor.value;

  var setBackgroundColor = CustomStyle.lightBackgroundColor.obs;
  Color get getBackgroundColor => setBackgroundColor.value;

  var setBorderLayoutColor = CustomStyle.lightBorderLayoutColor.obs;
  Color get getBorderLayoutColor => setBorderLayoutColor.value;

  var setTextButtonAreaColor = CustomStyle.lightTextButtonAreaColor.obs;
  Color get getTextButtonAreaColor => setTextButtonAreaColor.value;

  var setTextButtonHoverColor = CustomStyle.lightTextButtonHoverColor.obs;
  Color get getTextButtonHoverColor => setTextButtonHoverColor.value;

  var setSoftContainerColor = CustomStyle.lightSoftContainerColor.obs;
  Color get getSoftContainerColor => setSoftContainerColor.value;

  // static final lightTheme = ThemeData(
  //   brightness: Brightness.light,
  //   primaryColor: Colors.blue,
  //   scaffoldBackgroundColor: Colors.white,
  //   appBarTheme: const AppBarTheme(
  //     backgroundColor: lightBackgroundColor,
  //     foregroundColor: lightHighFontColor,
  //   ),
  //   textTheme: const TextTheme(
  //     bodyMedium: TextStyle(color: Colors.black),
  //   ),
  // );

  // static final darkTheme = ThemeData(
  //   brightness: Brightness.dark,
  //   primaryColor: Colors.teal,
  //   scaffoldBackgroundColor: Colors.black,
  //   appBarTheme: const AppBarTheme(
  //     backgroundColor: lightTextButtonAreaColor,
  //     foregroundColor: Colors.white,
  //   ),
  //   textTheme: const TextTheme(
  //     bodyMedium: TextStyle(color: Colors.white),
  //   ),
  // );

  @override
  void onInit() {
    setIsDarkMode.value = true;
    settingThemeData();
    super.onInit();
  }

  void settingThemeData() {
    setIsDarkMode.value = getIsDarkMode ? false : true;
    Get.changeThemeMode(getIsDarkMode ? ThemeMode.dark : ThemeMode.light);
    setSoftFontColor.value = getIsDarkMode
        ? CustomStyle.darkSoftFontColor
        : CustomStyle.lightSoftFontColor;
    setTextButtonAreaColor.value = getIsDarkMode
        ? CustomStyle.darkTextButtonAreaColor
        : CustomStyle.lightTextButtonAreaColor;
    setTextButtonHoverColor.value = getIsDarkMode
        ? CustomStyle.darkTextButtonHoverColor
        : CustomStyle.lightTextButtonHoverColor;
    setSoftContainerColor.value = getIsDarkMode
        ? CustomStyle.darkSoftContainerColor
        : CustomStyle.lightSoftContainerColor;
    setBackgroundColor.value = getIsDarkMode
        ? CustomStyle.darkBackgroundColor
        : CustomStyle.lightBackgroundColor;
    setBorderLayoutColor.value = getIsDarkMode
        ? CustomStyle.darkBorderLayoutColor
        : CustomStyle.lightBorderLayoutColor;
    setThemeData.value = ThemeData(
      brightness: getIsDarkMode ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: getBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: getBackgroundColor,
        // foregroundColor: getLightHighFontColor,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: getSoftFontColor),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: getTextButtonHoverColor,
          textStyle: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
