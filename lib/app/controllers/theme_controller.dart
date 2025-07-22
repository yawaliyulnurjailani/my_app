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

  var setButtonAreaColor = CustomStyle.lightButtonAreaColor.obs;
  Color get getButtonAreaColor => setButtonAreaColor.value;

  var setButtonHoverColor = CustomStyle.lightButtonHoverColor.obs;
  Color get getButtonHoverColor => setButtonHoverColor.value;

  var setSoftContainerColor = CustomStyle.lightSoftContainerColor.obs;
  Color get getSoftContainerColor => setSoftContainerColor.value;

  var setLogoColor = CustomStyle.lightLogoColor.obs;
  Color get getLogoColor => setLogoColor.value;

  @override
  void onInit() {
    setIsDarkMode.value = true;
    settingThemeData();
    super.onInit();
  }

  void settingThemeData() {
    setIsDarkMode.value = getIsDarkMode ? false : true;
    Get.changeThemeMode(getIsDarkMode ? ThemeMode.dark : ThemeMode.light);
    setHighFontColor.value = getIsDarkMode
        ? CustomStyle.darkHighFontColor
        : CustomStyle.lightHighFontColor;
    setSoftFontColor.value = getIsDarkMode
        ? CustomStyle.darkSoftFontColor
        : CustomStyle.lightSoftFontColor;
    setButtonAreaColor.value = getIsDarkMode
        ? CustomStyle.darkButtonAreaColor
        : CustomStyle.lightButtonAreaColor;
    setButtonHoverColor.value = getIsDarkMode
        ? CustomStyle.darkButtonHoverColor
        : CustomStyle.lightButtonHoverColor;
    setSoftContainerColor.value = getIsDarkMode
        ? CustomStyle.darkSoftContainerColor
        : CustomStyle.lightSoftContainerColor;
    setBackgroundColor.value = getIsDarkMode
        ? CustomStyle.darkBackgroundColor
        : CustomStyle.lightBackgroundColor;
    setBorderLayoutColor.value = getIsDarkMode
        ? CustomStyle.darkBorderLayoutColor
        : CustomStyle.lightBorderLayoutColor;
    setLogoColor.value =
        getIsDarkMode ? CustomStyle.darkLogoColor : CustomStyle.lightLogoColor;
    setThemeData.value = ThemeData(
      brightness: getIsDarkMode ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: getBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: getBackgroundColor,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: getSoftFontColor),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: getButtonHoverColor,
          textStyle: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
