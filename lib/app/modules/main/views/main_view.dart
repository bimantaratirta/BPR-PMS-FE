import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.handleWillPop,
      child: Scaffold(
        body: Obx(
          () => IndexedStack(index: controller.currentActiveBottomNavigationIndex.value, children: controller.pages),
        ),
      ),
    );
  }
}
