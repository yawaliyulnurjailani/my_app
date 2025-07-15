import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/text_button_comp.dart';
import '../../controllers/theme_controller.dart';

class SidebarView extends StatelessWidget {
  SidebarView({super.key});

  final ThemeController _theme = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Drawer(
        backgroundColor: _theme.getBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
              child: TextButtonComp.textButton1(
                text: Icon(
                  _theme.getIsDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: _theme.getSoftFontColor,
                  size: 30,
                ),
                onPressed: () {
                  _theme.settingThemeData();
                },
                textHoverColor: _theme.getHighFontColor,
                hoverColor: _theme.getTextButtonHoverColor,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
            ),
            sideMenu("About"),
            sideMenu("Education"),
            sideMenu("Experience"),
            sideMenu("Contact"),
          ],
        ),
      ),
    );
  }

  Widget sideMenu(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      ),
    );
  }
}
