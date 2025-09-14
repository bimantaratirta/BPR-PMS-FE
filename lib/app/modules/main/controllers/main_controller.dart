import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/data/main/bottom_navigation/bottom_navigation_item_model.dart';
import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const HOME_NAV_ID = 100;
const NASABAH_NAV_ID = 200;
const REPORT_NAV_ID = 300;
const PROFILE_NAV_ID = 400;

class MainController extends GetxController {
  final PageController pageController = PageController();

  var currentActiveBottomNavigationIndex = 0.obs;

  List<GetRouterOutlet> get pages => [
    GetRouterOutlet(key: Get.nestedKey(HOME_NAV_ID), initialRoute: Routes.HOME),
    GetRouterOutlet(key: Get.nestedKey(NASABAH_NAV_ID), initialRoute: Routes.NASABAH),
    GetRouterOutlet(key: Get.nestedKey(REPORT_NAV_ID), initialRoute: Routes.REPORT),
    GetRouterOutlet(key: Get.nestedKey(PROFILE_NAV_ID), initialRoute: Routes.PROFILE),
  ];

  List<BottomNavigationItemModel> get sidebarSettings => [
    BottomNavigationItemModel(
      onTap: () {
        changePage(0);
      },
      iconPath: IconAssets.home,
      iconColor: MainColor.blueNormal,
      label: "Beranda",
      labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blueNormal),
    ),
    BottomNavigationItemModel(
      onTap: () {
        changePage(1);
      },
      iconPath: IconAssets.nasabah,
      iconColor: MainColor.blueNormal,
      label: "Nasabah",
      labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blueNormal),
    ),
    BottomNavigationItemModel(
      onTap: () {
        changePage(2);
      },
      iconPath: IconAssets.report,
      iconColor: MainColor.blueNormal,
      label: "Laporan",
      labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blueNormal),
    ),
    BottomNavigationItemModel(
      onTap: () {
        changePage(3);
      },
      iconPath: IconAssets.profile,
      iconColor: MainColor.blueNormal,
      label: "Profil",
      labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blueNormal),
    ),
  ];

  void changePage(int index) {
    currentActiveBottomNavigationIndex.value = index;
  }
}
