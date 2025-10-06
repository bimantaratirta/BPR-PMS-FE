import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/data/main/bottom_navigation/bottom_navigation_item_model.dart';
import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const int AUTH_LOGIN_INDEX = 0;
const int AUTH_REGISTER_INDEX = 1;
const int HOME_INDEX = 2;
const int NASABAH_INDEX = 3;
const int REPORT_INDEX = 4;
const int PROFILE_INDEX = 5;
const int LO_INDEX = 6;
const int SLO_INDEX = 7;

class MainController extends GetxController {
  final PageController pageController = PageController();
  final authController = Get.put<AuthController>(AuthController(), permanent: true);

  var currentActiveBottomNavigationIndex = AUTH_LOGIN_INDEX.obs;

  static const int LOGIN_NAV_ID = 1;
  static const int REGISTER_NAV_ID = 2;
  static const int HOME_NAV_ID = 100;
  static const int NASABAH_NAV_ID = 200;
  static const int REPORT_NAV_ID = 300;
  static const int PROFILE_NAV_ID = 400;
  static const int LO_NAV_ID = 600;
  static const int SLO_NAV_ID = 700;

  late final List<Widget> pages = [
    GetRouterOutlet(key: Get.nestedKey(LOGIN_NAV_ID), initialRoute: Routes.AUTH_LOGIN),
    GetRouterOutlet(key: Get.nestedKey(REGISTER_NAV_ID), initialRoute: Routes.AUTH_REGISTER),
    GetRouterOutlet(key: Get.nestedKey(HOME_NAV_ID), initialRoute: Routes.HOME),
    GetRouterOutlet(key: Get.nestedKey(NASABAH_NAV_ID), initialRoute: Routes.NASABAH),
    GetRouterOutlet(key: Get.nestedKey(REPORT_NAV_ID), initialRoute: Routes.REPORT),
    GetRouterOutlet(key: Get.nestedKey(PROFILE_NAV_ID), initialRoute: Routes.PROFILE),
    GetRouterOutlet(key: Get.nestedKey(LO_NAV_ID), initialRoute: Routes.LO),
    GetRouterOutlet(key: Get.nestedKey(SLO_NAV_ID), initialRoute: Routes.SLO),
  ];

  List<BottomNavigationItemModel> get sidebarSettings {
    final items = <BottomNavigationItemModel>[];

    items.add(
      BottomNavigationItemModel(
        onTap: () => changePage(HOME_INDEX),
        index: HOME_INDEX,
        iconPath: IconAssets.home,
        iconColor: MainColor.blueNormal,
        label: "Beranda",
        labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blueNormal),
      ),
    );

    switch (authController.pickRole.value) {
      case UserRole.lo:
        items.addAll([
          BottomNavigationItemModel(
            onTap: () => changePage(NASABAH_INDEX),
            index: NASABAH_INDEX,
            iconPath: IconAssets.nasabah,
            iconColor: MainColor.blueNormal,
            label: "Nasabah",
            labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blueNormal),
          ),
          BottomNavigationItemModel(
            onTap: () => changePage(REPORT_INDEX),
            index: REPORT_INDEX,
            iconPath: IconAssets.report,
            iconColor: MainColor.blueNormal,
            label: "Laporan",
            labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blueNormal),
          ),
        ]);
        break;
      case UserRole.slo:
        items.addAll([
          BottomNavigationItemModel(
            onTap: () => changePage(REPORT_INDEX),
            index: REPORT_INDEX,
            iconPath: IconAssets.report,
            iconColor: MainColor.blueNormal,
            label: "Laporan",
            labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blueNormal),
          ),
          BottomNavigationItemModel(
            onTap: () => changePage(LO_INDEX),
            index: LO_INDEX,
            iconPath: IconAssets.peopleDocument,
            iconColor: MainColor.blueNormal,
            label: "LO",
            labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blueNormal),
          ),
        ]);
        break;
      case UserRole.am:
        items.addAll([
          BottomNavigationItemModel(
            onTap: () => changePage(REPORT_INDEX),
            index: REPORT_INDEX,
            iconPath: IconAssets.report,
            iconColor: MainColor.blueNormal,
            label: "Laporan",
            labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blueNormal),
          ),
          BottomNavigationItemModel(
            onTap: () => changePage(SLO_INDEX),
            index: SLO_INDEX,
            iconPath: IconAssets.peopleDocument,
            iconColor: MainColor.blueNormal,
            label: "SLO",
            labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blueNormal),
          ),
        ]);
        break;
      default:
        break;
    }

    items.add(
      BottomNavigationItemModel(
        onTap: () => changePage(PROFILE_INDEX),
        index: PROFILE_INDEX,
        iconPath: IconAssets.profile,
        iconColor: MainColor.blueNormal,
        label: "Profil",
        labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blueNormal),
      ),
    );

    return items;
  }

  void changePage(int index) {
    currentActiveBottomNavigationIndex.value = index;
  }

  Future<bool> handleWillPop() async {
    final canPop = Get.rootDelegate.navigatorKey.currentState?.canPop() ?? false;
    if (canPop) {
      Get.rootDelegate.popRoute();
      return false;
    }
    return true;
  }
}
