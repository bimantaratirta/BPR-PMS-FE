import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/data/main/bottom_navigation/bottom_navigation_item_model.dart';
import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';

class MainController extends GetxController {
  // ---- Dependencies
  final authController = Get.find<AuthController>();

  // ---- State
  final RxInt currentIndex = 0.obs;
  final RxList<BottomNavigationItemModel> sidebarSettings = <BottomNavigationItemModel>[].obs;
  late Disposer _roleDisposer;

  // Index konstanta
  static const int HOME_INDEX = 0;
  static const int NASABAH_INDEX = 1;
  static const int REPORT_INDEX = 2;
  static const int PROFILE_INDEX = 3;
  static const int LO_INDEX = 2; // untuk SLO role, urutan berbeda
  static const int SLO_INDEX = 2; // untuk AM role, urutan berbeda
  static const int OFFICE_INDEX = 2; // untuk Direksi role, urutan berbeda

  // ====== ROUTE MAPS per role (child dari /main) ======
  // Urutan list = urutan tab di bottom nav untuk role tsb.
  List<String> _routesForRole(UserRole? role) {
    switch (role) {
      case UserRole.lo:
        // [Home, Nasabah, Report, Profile]
        return [Routes.HOME, Routes.NASABAH, Routes.REPORT, Routes.PROFILE];
      case UserRole.slo:
        // [Home, Report, LO, Profile]
        return [Routes.HOME, Routes.REPORT, Routes.LO, Routes.PROFILE];
      case UserRole.am:
        // [Home, Report, SLO, Profile]
        return [Routes.HOME, Routes.REPORT, Routes.SLO, Routes.PROFILE];
      case UserRole.direksi:
        // [Home, Report, Office, Profile]
        return [Routes.HOME, Routes.REPORT, Routes.OFFICE, Routes.PROFILE];
      default:
        return [];
    }
  }

  // ====== BUILD SIDEBAR (BOTTOM NAV) ITEMS SESUAI ROLE ======
  List<BottomNavigationItemModel> _buildItems(UserRole? role) {
    final items = <BottomNavigationItemModel>[];

    // Home selalu ada
    items.add(
      BottomNavigationItemModel(
        onTap: () => changePage(0),
        index: 0,
        iconPath: IconAssets.home,
        iconColor: MainColor.blue5,
        label: 'Beranda',
        labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blue5),
      ),
    );

    // Middle items berdasarkan role
    switch (role) {
      case UserRole.lo:
        // [Nasabah, Laporan]
        items.addAll([
          BottomNavigationItemModel(
            onTap: () => changePage(1),
            index: 1,
            iconPath: IconAssets.nasabah,
            iconColor: MainColor.blue5,
            label: 'Nasabah',
            labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blue5),
          ),
          BottomNavigationItemModel(
            onTap: () => changePage(2),
            index: 2,
            iconPath: IconAssets.report,
            iconColor: MainColor.blue5,
            label: 'Laporan',
            labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blue5),
          ),
        ]);
        break;

      case UserRole.slo:
        // [Laporan, LO]
        items.addAll([
          BottomNavigationItemModel(
            onTap: () => changePage(1),
            index: 1,
            iconPath: IconAssets.report,
            iconColor: MainColor.blue5,
            label: 'Laporan',
            labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blue5),
          ),
          BottomNavigationItemModel(
            onTap: () => changePage(2),
            index: 2,
            iconPath: IconAssets.peopleDocument,
            iconColor: MainColor.blue5,
            label: 'LO',
            labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blue5),
          ),
        ]);
        break;

      case UserRole.am:
        // [Laporan, SLO]
        items.addAll([
          BottomNavigationItemModel(
            onTap: () => changePage(1),
            index: 1,
            iconPath: IconAssets.report,
            iconColor: MainColor.blue5,
            label: 'Laporan',
            labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blue5),
          ),
          BottomNavigationItemModel(
            onTap: () => changePage(2),
            index: 2,
            iconPath: IconAssets.peopleDocument,
            iconColor: MainColor.blue5,
            label: 'SLO',
            labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blue5),
          ),
        ]);
        break;

      case UserRole.direksi:
        // [Laporan, Office]
        items.addAll([
          BottomNavigationItemModel(
            onTap: () => changePage(1),
            index: 1,
            iconPath: IconAssets.report,
            iconColor: MainColor.blue5,
            label: 'Laporan',
            labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blue5),
          ),
          BottomNavigationItemModel(
            onTap: () => changePage(2),
            index: 2,
            iconPath: IconAssets.office,
            iconColor: MainColor.blue5,
            label: 'Kantor',
            labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blue5),
          ),
        ]);
        break;

      default:
        break;
    }

    // Profile selalu ada
    items.add(
      BottomNavigationItemModel(
        onTap: () => changePage(3),
        index: 3,
        iconPath: IconAssets.profile,
        iconColor: MainColor.blue5,
        label: 'Profil',
        labelStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500, color: MainColor.blue5),
      ),
    );

    return items;
  }

  // ====== NAVIGASI ANTAR TAB ======
  void changePage(int index) {
    final role = authController.pickRole.value;
    final routes = _routesForRole(role);

    // clamp index jika out of range
    final safeIndex = index.clamp(0, routes.length - 1);
    if (currentIndex.value == safeIndex) return;

    currentIndex.value = safeIndex;
    final childPath = routes[safeIndex]; // contoh: Routes.HOME, Routes.NASABAH, dst.

    Get.rootDelegate.toNamed('${Routes.MAIN}$childPath');
  }

  // Panggil ini setelah login jika perlu
  void navigateToHome() {
    currentIndex.value = 0; // Home
    Get.rootDelegate.offNamed('${Routes.MAIN}${Routes.HOME}');
  }

  // Sinkronkan index saat deep-link / refresh web mengarah ke child tertentu
  void syncIndexFromLocation() {
    final role = authController.pickRole.value;
    final routes = _routesForRole(role);

    final location = Get.rootDelegate.currentConfiguration?.location ?? '';
    // location contoh: /main/home, /main/report, ...
    final matched = routes.indexWhere((r) => location.endsWith(r));
    if (matched != -1) {
      currentIndex.value = matched;
    } else {
      // fallback ke Home
      currentIndex.value = 0;
    }
  }

  // ====== Lifecycle ======
  @override
  void onInit() {
    super.onInit();

    final role = authController.pickRole.value;
    sidebarSettings.assignAll(_buildItems(role));

    // Simpan disposer yang dikembalikan oleh ever()
    _roleDisposer = ever(authController.pickRole, (UserRole? newRole) {
      final newItems = _buildItems(newRole);
      sidebarSettings.assignAll(newItems);

      final routes = _routesForRole(newRole);
      if (currentIndex.value >= routes.length) {
        currentIndex.value = 0;
      }
      final childPath = routes[currentIndex.value];

      Get.rootDelegate.offNamed('${Routes.MAIN}$childPath');
    });

    syncIndexFromLocation();
  }

  void stopListeners() {
    _roleDisposer();
  }
}
