import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/data/main/bottom_navigation/bottom_navigation_item_model.dart';
import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const LOGIN_NAV_ID = 01;
const REGISTER_NAV_ID = 02;
const HOME_NAV_ID = 100;
const NASABAH_NAV_ID = 200;
const REPORT_NAV_ID = 300;
const PROFILE_NAV_ID = 400;

const int AUTH_LOGIN_INDEX = 0;
const int AUTH_REGISTER_INDEX = 1;
const int HOME_INDEX = 2;
const int NASABAH_INDEX = 3;
const int REPORT_INDEX = 4;
const int PROFILE_INDEX = 5;

class MainController extends GetxController {
  final PageController pageController = PageController();

  var currentActiveBottomNavigationIndex = AUTH_LOGIN_INDEX.obs;

  List<GetRouterOutlet> get pages => [
    GetRouterOutlet(key: Get.nestedKey(LOGIN_NAV_ID), initialRoute: Routes.AUTH_LOGIN),
    GetRouterOutlet(key: Get.nestedKey(REGISTER_NAV_ID), initialRoute: Routes.AUTH_REGISTER),
    GetRouterOutlet(key: Get.nestedKey(HOME_NAV_ID), initialRoute: Routes.HOME),
    GetRouterOutlet(key: Get.nestedKey(NASABAH_NAV_ID), initialRoute: Routes.NASABAH),
    GetRouterOutlet(key: Get.nestedKey(REPORT_NAV_ID), initialRoute: Routes.REPORT),
    GetRouterOutlet(key: Get.nestedKey(PROFILE_NAV_ID), initialRoute: Routes.PROFILE),
  ];

  List<BottomNavigationItemModel> get sidebarSettings => [
    BottomNavigationItemModel(
      onTap: () {
        changePage(HOME_INDEX);
      },
      index: HOME_INDEX,
      iconPath: IconAssets.home,
      iconColor: MainColor.blueNormal,
      label: "Beranda",
      labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blueNormal),
    ),
    BottomNavigationItemModel(
      onTap: () {
        changePage(NASABAH_INDEX);
      },
      index: NASABAH_INDEX,
      iconPath: IconAssets.nasabah,
      iconColor: MainColor.blueNormal,
      label: "Nasabah",
      labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blueNormal),
    ),
    BottomNavigationItemModel(
      onTap: () {
        changePage(REPORT_INDEX);
      },
      index: REPORT_INDEX,
      iconPath: IconAssets.report,
      iconColor: MainColor.blueNormal,
      label: "Laporan",
      labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blueNormal),
    ),
    BottomNavigationItemModel(
      onTap: () {
        changePage(PROFILE_INDEX);
      },
      index: PROFILE_INDEX,
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
