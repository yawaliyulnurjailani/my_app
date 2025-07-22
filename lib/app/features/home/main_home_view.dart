import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/app/components/rotating_container_comp.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../assets/style/custom_style.dart';
import '../../components/hover_scale_wrap_comp.dart';
import '../../components/slide_fade_on_visible_comp.dart';
import '../../controllers/theme_controller.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({super.key});

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  final ThemeController _theme = Get.find();

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomStyle.conditionDevice(context)
          ? buildMobileResponsive(context)
          : buildWebResponsive(context),
    );
  }

  Widget buildMobileResponsive(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SlideFadeOnVisibleComp(
            enableReverse: true,
            offsetX: -300,
            child: imageProfile(450, 450),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SlideFadeOnVisibleComp(
                      enableReverse: true,
                      offsetX: -300,
                      child: greetingInfo(TextAlign.center),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: SlideFadeOnVisibleComp(
                      enableReverse: true,
                      offsetX: -300,
                      child: textInfo(TextAlign.center),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SlideFadeOnVisibleComp(
                enableReverse: true,
                offsetX: -300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HoverScaleWrapper(
                      onTap: () {
                        _launchURL("https://github.com/yawaliyulnurjailani");
                      },
                      child: socialInfo(
                        "${CustomStyle.urlIcon}/github.png",
                        "Github",
                      ),
                    ),
                    const SizedBox(width: 20),
                    HoverScaleWrapper(
                      onTap: () {
                        _launchURL(
                            "https://www.linkedin.com/in/yawaliyulnurjailani");
                      },
                      child: socialInfo(
                        "${CustomStyle.urlIcon}/linkedin.png",
                        "LinkedIn",
                      ),
                    ),
                    const SizedBox(width: 20),
                    HoverScaleWrapper(
                      onTap: () {
                        _launchURL("https://wa.me/6285376988609");
                      },
                      child: socialInfo(
                        "${CustomStyle.urlIcon}/whatsapp.png",
                        "Whatsapp",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildWebResponsive(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideFadeOnVisibleComp(
            enableReverse: true,
            offsetX: -300,
            child: imageProfile(500, 500),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SlideFadeOnVisibleComp(
              enableReverse: true,
              child: Column(
                children: [
                  HoverScaleWrapper(
                    scale: 1.03,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: greetingInfo(TextAlign.left),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: textInfo(TextAlign.justify),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      HoverScaleWrapper(
                        onTap: () {
                          _launchURL("https://github.com/yawaliyulnurjailani");
                        },
                        child: socialInfo(
                          "${CustomStyle.urlIcon}/github.png",
                          "Github",
                        ),
                      ),
                      const SizedBox(width: 20),
                      HoverScaleWrapper(
                        onTap: () {
                          _launchURL(
                              "https://www.linkedin.com/in/yawaliyulnurjailani");
                        },
                        child: socialInfo(
                          "${CustomStyle.urlIcon}/linkedin.png",
                          "LinkedIn",
                        ),
                      ),
                      const SizedBox(width: 20),
                      HoverScaleWrapper(
                        onTap: () {
                          _launchURL("https://wa.me/6285376988609");
                        },
                        child: socialInfo(
                          "${CustomStyle.urlIcon}/whatsapp.png",
                          "Whatsapp",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageProfile(double width, double height) {
    // Ambil warna dari observable di luar builder
    final softColor = _theme.getSoftContainerColor.withOpacity(0.3);
    final solidColor = _theme.getSoftContainerColor;

    return HoverScaleWrapper(
      scale: 1.03,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Lapisan bawah: berputar (tanpa Obx)
            RotatingContainerComp(
              width: width + 100,
              height: height + 100,
              color: softColor,
            ),
            // Lapisan atas: statis (tanpa Obx)
            Container(
              width: width - 100,
              height: height - 100,
              decoration: BoxDecoration(
                color: solidColor,
                borderRadius: BorderRadius.circular(30),
              ),
              clipBehavior: Clip
                  .antiAlias, // penting untuk memotong gambar sesuai borderRadius
              child: Image.asset(
                "${CustomStyle.urlImage}/profile1.jpg",
                fit: BoxFit.cover, // biar gambar menutupi seluruh area
                filterQuality: FilterQuality.high,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget greetingInfo(textAlign) {
    return Text(
      "Hai! Saya Yawaliyul Nur Jailani",
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: _theme.getHighFontColor,
      ),
    );
  }

  Widget textInfo(textAlign) {
    return Text(
      // "Saya adalah seorang pengembang aplikasi mobile yang suka ngulik teknologi dan membangun produk digital yang berguna. Dengan pengalaman di Flutter dan GetX, saya selalu antusias belajar hal baru dan mencari cara kreatif untuk menyelesaikan masalah. Bagi saya, setiap baris kode adalah bagian dari cerita besar yang sedang dibangun.",
      "Seorang Fullstack Developer yang berfokus pada pengembangan aplikasi web dan mobile. Saya membangun solusi digital menggunakan PHP, JavaScript, CSS, Flutter, Laravel, CodeIgniter, dan ASP.NET Web API.",
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 16,
        color: _theme.getSoftFontColor,
      ),
    );
  }

  Widget socialInfo(String urlIcon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: _theme.getButtonAreaColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(
            urlIcon,
            filterQuality: FilterQuality.high,
            color: _theme.getSoftFontColor,
            width: 25,
            height: 25,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: _theme.getSoftFontColor,
            ),
          ),
        ],
      ),
    );
  }
}
