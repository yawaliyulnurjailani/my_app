import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LayoutController extends GetxController {
  // Scroll state
  final scrollController = ScrollController();

  // key tiap menu
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final projectKey = GlobalKey();
  final contactKey = GlobalKey();

  // sebagai parameter untuk heigh setiap menu
  final setHeightHome = 0.0.obs;
  double get getHeightHome => setHeightHome.value;

  final setHeightAbout = 0.0.obs;
  double get getHeightAbout => setHeightAbout.value;

  final setHeightProject = 0.0.obs;
  double get getHeightProject => setHeightProject.value;

  final setHeightContact = 0.0.obs;
  double get getHeightContact => setHeightContact.value;

  // sebagai parameter value scroll
  final setPositionValue = 0.0.obs;
  double get getPositionValue => setPositionValue.value;

  // sebagai parameter kondisi untuk tombol scroll to top
  final setScrollToTop = false.obs;
  bool get getScrollToTop => setScrollToTop.value;

  @override
  void onInit() {
    scrollController.addListener(checkScrollToTopVisibility);

    // Dapatkan value height masing-masing menu
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final boxHome = homeKey.currentContext!.findRenderObject() as RenderBox;
      final boxAbout = aboutKey.currentContext!.findRenderObject() as RenderBox;
      final boxProject =
          projectKey.currentContext!.findRenderObject() as RenderBox;
      final boxContact =
          contactKey.currentContext!.findRenderObject() as RenderBox;
      setHeightHome.value = boxHome.size.height;
      setHeightAbout.value = boxAbout.size.height;
      setHeightProject.value = boxProject.size.height;
      setHeightContact.value = boxContact.size.height;
    });
    super.onInit();
  }

  // Scroll ke posisi section berdasarkan key
  void scrollToView(GlobalKey key) {
    if (key == homeKey) {
      setPositionValue.value = 0;
    } else if (key == aboutKey) {
      setPositionValue.value = getHeightHome;
    } else if (key == projectKey) {
      setPositionValue.value = getHeightAbout + getHeightAbout;
    } else if (key == contactKey) {
      setPositionValue.value =
          getHeightAbout + getHeightAbout + getHeightProject;
    }

    scrollController.animateTo(
      setPositionValue.value,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // Cek apakah posisi scroll sudah lewat 500px
  void checkScrollToTopVisibility() {
    setPositionValue.value = scrollController.position.pixels;
    if (scrollController.position.pixels > 500) {
      if (!getScrollToTop) setScrollToTop.value = true;
    } else {
      if (getScrollToTop) setScrollToTop.value = false;
    }
  }

  // Scroll ke atas
  void scrollToTop() {
    setPositionValue.value = scrollController.position.pixels;
    final offset = scrollController.offset;
    final duration = Duration(
      milliseconds: (offset / 8).clamp(100, 400).toInt(),
    );
    scrollController.animateTo(
      0,
      duration: duration,
      curve: Curves.easeOut,
    );
  }
}
