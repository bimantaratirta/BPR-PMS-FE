import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/modules/main/controllers/main_controller.dart';
import 'package:bpr_pms/app/widgets/build_navigation/build_bottom_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildBottomNavigationBar extends StatelessWidget {
  const BuildBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();

    return BottomAppBar(
      color: SecondaryColor.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...mainController.sidebarSettings.asMap().entries.map((entry) {
            int index = entry.key;
            var item = entry.value;
            return Obx(() {
              bool isActive = mainController.currentActiveBottomNavigationIndex.value == index;
              return BuildBottomNavigationBarItem(isActive: isActive, data: item, index: index);
            });
          }),
        ],
      ),
    );
  }
}
