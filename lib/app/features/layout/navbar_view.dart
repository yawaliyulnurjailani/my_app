import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/hover_scale_wrap_comp.dart';
import '../../components/text_button_comp.dart';
import '../../controllers/layout_controller.dart';
import '../../controllers/theme_controller.dart';

class NavbarView extends StatelessWidget {
  NavbarView({super.key});

  final ThemeController _theme = Get.find();
  final LayoutController _layout = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Menu("Beranda", _layout.homeKey),
        Menu("Tentang Saya", _layout.aboutKey),
        Menu("Proyek", _layout.projectKey),
        Menu("Kontak", _layout.contactKey),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(
            () => HoverScaleWrapper(
              child: IconButton(
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
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget Menu(String title, GlobalKey key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: HoverScaleWrapper(
        child: TextButtonComp.textButton1(
          text: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: _theme.getSoftFontColor,
            ),
          ),
          onPressed: () {
            _layout.scrollToView(key);
          },
          textHoverColor: _theme.getHighFontColor,
          hoverColor: _theme.getButtonHoverColor,
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        ),
      ),
    );
  }
}
