import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/text_button_comp.dart';
import '../../controllers/theme_controller.dart';

class NavbarView extends StatelessWidget {
  NavbarView({super.key});

  final ThemeController _theme = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Menu("About"),
        Menu("Education"),
        Menu("Experience"),
        Menu("Contact"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(
            () => IconButton(
              onPressed: () {
                _theme.settingThemeData();
              },
              icon: Icon(
                _theme.getIsDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: _theme.getSoftFontColor,
                size: 26,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget Menu(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButtonComp.textButton1(
        text: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: _theme.getSoftFontColor,
          ),
        ),
        onPressed: () {},
        textHoverColor: _theme.getHighFontColor,
        hoverColor: _theme.getTextButtonHoverColor,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
      ),
    );
  }
}
