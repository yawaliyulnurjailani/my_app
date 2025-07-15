import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../assets/style/custom_style.dart';
import '../../controllers/theme_controller.dart';
import '../about/main_about_view.dart';
import '../experience/main_experience_view.dart';
import 'navbar_view.dart';
import 'sidebar_view.dart';

class MainLayoutView extends StatefulWidget {
  const MainLayoutView({super.key});

  @override
  State<MainLayoutView> createState() => _MainLayoutViewState();
}

class _MainLayoutViewState extends State<MainLayoutView> {
  final ThemeController _theme = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: "Portofolio",
        debugShowCheckedModeBanner: false,
        theme: _theme.getThemeData,
        initialRoute: "/",
        home: LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              backgroundColor: _theme.getBackgroundColor
                  .withOpacity(_theme.getIsDarkMode ? 0.9 : 0.3),
              body: Center(
                child: Container(
                  width: CustomStyle.maxScreenSize,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: _theme.getBorderLayoutColor,
                        width: 2.0,
                      ),
                      right: BorderSide(
                        color: _theme.getBorderLayoutColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: Scaffold(
                    appBar: AppBar(
                      surfaceTintColor: Colors.transparent,
                      titleSpacing: 20,
                      centerTitle: false,
                      toolbarHeight: 80,
                      elevation: 0,
                      title: const Text(
                        "YAWALIYUL",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      actions: CustomStyle.conditionDevice(context)
                          ? null
                          : [NavbarView()],
                    ),
                    endDrawer: CustomStyle.conditionDevice(context)
                        ? SidebarView()
                        : null,
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context)
                                .copyWith(scrollbars: false),
                            child: const SingleChildScrollView(
                              physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              child: Column(
                                children: [
                                  MainAboutView(),
                                  MainExperienceView(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
