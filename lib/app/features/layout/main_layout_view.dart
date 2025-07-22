import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../assets/style/custom_style.dart';
import '../../components/hover_scale_wrap_comp.dart';
import '../../controllers/layout_controller.dart';
import '../../controllers/theme_controller.dart';
import '../about/main_about_view.dart';
import '../contact/main_contact_view.dart';
import '../project/main_project_view.dart';
import '../home/main_home_view.dart';
import 'navbar_view.dart';
import 'sidebar_view.dart';

class MainLayoutView extends StatefulWidget {
  const MainLayoutView({super.key});

  @override
  State<MainLayoutView> createState() => _MainLayoutViewState();
}

class _MainLayoutViewState extends State<MainLayoutView> {
  final ThemeController _theme = Get.put(ThemeController());
  final LayoutController _layout = Get.put(LayoutController());

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
                      title: HoverScaleWrapper(
                        onTap: () {
                          _layout.scrollToView(_layout.homeKey);
                        },
                        child: Image.asset(
                          "${CustomStyle.urlImage}/ynj-removebg.png",
                          width: 95,
                          height: 95,
                          filterQuality: FilterQuality.high,
                          color: _theme.getLogoColor,
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
                            child: SingleChildScrollView(
                              controller: _layout.scrollController,
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    key: _layout.homeKey,
                                    child: const MainHomeView(),
                                  ),
                                  Container(
                                    key: _layout.aboutKey,
                                    child: const MainAboutView(),
                                  ),
                                  Container(
                                    key: _layout.projectKey,
                                    child: const MainProjectView(),
                                  ),
                                  Container(
                                    key: _layout.contactKey,
                                    child: const MainContactView(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    floatingActionButton: Obx(
                      () {
                        if (_layout.getScrollToTop) {
                          return FloatingActionButton(
                            backgroundColor: _theme.getButtonAreaColor,
                            foregroundColor: _theme.getSoftFontColor,
                            elevation: 0,
                            onPressed: () {
                              _layout.scrollController.animateTo(
                                0,
                                duration: const Duration(
                                  milliseconds: 3000,
                                ),
                                curve: Curves.bounceOut,
                              );
                            },
                            child: Icon(
                              Icons.arrow_upward_rounded,
                              color: _theme.getSoftFontColor,
                            ),
                          );
                        }
                        return const SizedBox();
                      },
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
