import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import '../../../assets/style/custom_style.dart';
import '../../controllers/theme_controller.dart';

class MainAboutView extends StatefulWidget {
  const MainAboutView({super.key});

  @override
  State<MainAboutView> createState() => _MainAboutViewState();
}

class _MainAboutViewState extends State<MainAboutView>
    with SingleTickerProviderStateMixin {
  final ThemeController _theme = Get.find();
  late AnimationController _animImageProfile;

  @override
  void initState() {
    super.initState();
    _animImageProfile = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(); // putar terus
  }

  @override
  void dispose() {
    _animImageProfile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: CustomStyle.maxWidth(context),
        height: CustomStyle.maxHeight(context),
        child: CustomStyle.conditionDevice(context)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 20,
                    ),
                    child: imageProfile(450, 450),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        textInfo(),
                      ],
                    ),
                  )
                ],
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    imageProfile(400, 400),
                    textInfo(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget imageProfile(double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Layer bawah: berputar
          AnimatedBuilder(
            animation: _animImageProfile,
            builder: (context, child) {
              return Transform.rotate(
                angle: _animImageProfile.value * 2 * pi,
                child: child,
              );
            },
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: _theme.getSoftContainerColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          // Layer atas: statis
          Container(
            width: width - 100,
            height: height - 100,
            decoration: BoxDecoration(
              color: _theme.getSoftContainerColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Text(
                "Image Profile",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textInfo() {
    return Expanded(
      child: Text(
        "Halo! Saya Yawaliyul Nur Jailani, seorang pengembang aplikasi mobile yang suka ngulik teknologi dan membangun produk digital yang berguna. Dengan pengalaman di Flutter dan GetX, saya selalu antusias belajar hal baru dan mencari cara kreatif untuk menyelesaikan masalah. Bagi saya, setiap baris kode adalah bagian dari cerita besar yang sedang dibangun.",
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: _theme.getSoftFontColor,
        ),
      ),
    );
  }
}
