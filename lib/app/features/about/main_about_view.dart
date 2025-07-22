import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../assets/style/custom_style.dart';
import '../../components/hover_scale_wrap_comp.dart';
import '../../components/slide_fade_on_visible_comp.dart';
import '../../controllers/theme_controller.dart';

class MainAboutView extends StatefulWidget {
  const MainAboutView({super.key});

  @override
  State<MainAboutView> createState() => _MainAboutViewState();
}

class _MainAboutViewState extends State<MainAboutView> {
  final ThemeController _theme = Get.find();

  final List<String> skills = [
    "Flutter",
    "ASP .Net Web API",
    "SQL Server",
    "GIT",
    "Github",
    "JavaScript",
    "CSS",
    "PHP",
    "Laravel",
    "Codeigniter",
    "MySQL",
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomStyle.conditionDevice(context)
          ? buildMobileResponsive(context)
          : buildWebResponsive(context),
    );
  }

  Widget buildMobileResponsive(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SlideFadeOnVisibleComp(
            enableReverse: true,
            offsetX: -300,
            child: buildTitle(),
          ),
          const SizedBox(height: 50),
          HoverScaleWrapper(
            scale: 1.03,
            child: SlideFadeOnVisibleComp(
              enableReverse: true,
              offsetX: -300,
              child: buildGetToKnow(
                MainAxisAlignment.start,
                CrossAxisAlignment.center,
              ),
            ),
          ),
          const SizedBox(height: 20),
          HoverScaleWrapper(
            scale: 1.03,
            child: SlideFadeOnVisibleComp(
              enableReverse: true,
              offsetX: -300,
              child: buildMySkill(
                MainAxisAlignment.start,
                CrossAxisAlignment.center,
                WrapAlignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWebResponsive(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
      child: Column(
        children: [
          SlideFadeOnVisibleComp(
            enableReverse: true,
            offsetX: 0,
            duration: const Duration(seconds: 2),
            child: buildTitle(),
          ),
          const SizedBox(height: 80),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: HoverScaleWrapper(
                  scale: 1.03,
                  child: SlideFadeOnVisibleComp(
                    enableReverse: true,
                    offsetX: -300,
                    child: buildGetToKnow(
                      MainAxisAlignment.start,
                      CrossAxisAlignment.start,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 50),
              Expanded(
                child: HoverScaleWrapper(
                  scale: 1.03,
                  child: SlideFadeOnVisibleComp(
                    enableReverse: true,
                    offsetX: 300,
                    child: buildMySkill(
                      MainAxisAlignment.start,
                      CrossAxisAlignment.start,
                      WrapAlignment.start,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return HoverScaleWrapper(
      scale: 1.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "TENTANG SAYA",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: _theme.getHighFontColor,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: 50,
            height: 6,
            decoration: BoxDecoration(
              color: _theme.getSoftFontColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGetToKnow(maa, caa) {
    return Column(
      mainAxisAlignment: maa,
      crossAxisAlignment: caa,
      children: [
        Text(
          "Sekilas Tentang Saya",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _theme.getHighFontColor,
          ),
        ),
        const SizedBox(height: 10),
        buildParagraph(
          "Saya adalah seorang Fullstack Developer yang memiliki keahlian dalam membangun aplikasi web dan mobile, baik dari sisi frontend maupun backend. Berpengalaman menggunakan berbagai teknologi seperti PHP, JavaScript, CSS, dan Flutter untuk membangun antarmuka yang responsif dan user-friendly.",
        ),
        buildParagraph(
          "Di sisi backend, saya terbiasa menggunakan framework Laravel, CodeIgniter, serta ASP.NET Web API untuk membangun API dan sistem yang scalable. Saya juga menguasai database SQL Server dan MySQL serta terbiasa bekerja dengan Git dan GitHub untuk kolaborasi dan version control.",
        ),
        buildParagraph(
          "Saya siap berkontribusi dalam tim pengembangan yang mengutamakan kualitas, efisiensi, dan kolaborasi.",
        ),
      ],
    );
  }

  Widget buildMySkill(maa, caa, wa) {
    return Column(
      mainAxisAlignment: maa,
      crossAxisAlignment: caa,
      children: [
        Text(
          "Apa yang Saya Kuasai?",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _theme.getHighFontColor,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: wa,
          children: skills.map((skill) => buildSkillChip(skill)).toList(),
        ),
      ],
    );
  }

  Widget buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 16,
          color: _theme.getSoftFontColor,
        ),
      ),
    );
  }

  Widget buildSkillChip(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(
        color: _theme.getSoftContainerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: _theme.getSoftFontColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
