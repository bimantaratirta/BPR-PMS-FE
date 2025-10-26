import 'package:bpr_pms/app/data/modules/dashboard/dashboard_service.dart';
import 'package:bpr_pms/app/data/modules/dashboard/models/dashboard_am_model.dart';
import 'package:bpr_pms/app/data/modules/region/models/region_model.dart';
import 'package:bpr_pms/app/data/modules/region/region_service.dart';
import 'package:bpr_pms/app/data/modules/user/models/user_model.dart';
import 'package:bpr_pms/app/data/modules/user/user_service.dart';
import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfficeOfficeDetailController extends GetxController {
  final RegionService regionService = RegionService();
  final UserService userService = UserService();
  final DashboardService dashboardService = DashboardService();
  final AuthController authController = Get.find<AuthController>();

  RxString selectedLoNasabahDisplayFilter = 'minggu'.obs;
  Rx<List<Map<String, String>>> itemsSelectLoNasabahDisplayFilter = Rx<List<Map<String, String>>>([
    {"value": "minggu", "label": "Minggu"},
    {"value": "bulan", "label": "Bulan"},
  ]);

  final RxString id = ''.obs;
  final Rx<RegionModel?> regionData = Rx<RegionModel?>(null);
  final Rx<UserModel?> userAmData = Rx<UserModel?>(null);
  final Rx<DashboardAmModel?> dashboardAmData = Rx<DashboardAmModel?>(null);
  final RxList<Map<String, dynamic>> sloNasabahChartData = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final RxString message = ''.obs;
  final RxInt totalWeekCurrentPeriod = 0.obs;
  final RxInt totalMonthCurrentPeriod = 0.obs;
  final RxDouble totalWeekPercentageChange = 0.0.obs;
  final RxDouble totalMonthPercentageChange = 0.0.obs;

  void changeSelectedLoNasabahDisplayFilter(String value) {
    selectedLoNasabahDisplayFilter.value = value;
    getDashboardAm(Get.context!);
  }

  @override
  void onInit() {
    super.onInit();
    ever(dashboardAmData, _updateSloNasabahChart);

    final String? itemId = Get.parameters['id'];

    if (itemId != null) {
      id.value = itemId;
      Future.microtask(() async {
        await getUserAm(Get.context!, itemId);
        await getRegionById(Get.context!, itemId);
        await getDashboardAm(Get.context!);
      });
    }
  }

  void _updateSloNasabahChart(DashboardAmModel? data) {
    if (data == null) {
      sloNasabahChartData.clear();
      return;
    }

    final List<Map<String, dynamic>> transformedList =
        data.sloReports?.map((item) {
          return <String, dynamic>{
            'label': item.sloName,
            'value': selectedLoNasabahDisplayFilter.value == 'minggu'
                ? item.currentPeriodReportsWeek
                : item.currentPeriodReportsMonth,
          };
        }).toList() ??
        <Map<String, dynamic>>[];

    sloNasabahChartData.assignAll(transformedList);
  }

  Future<void> getRegionById(BuildContext context, String id) async {
    if (isLoading.value) {
      return;
    }

    try {
      isLoading.value = true;
      message.value = '';

      final response = await regionService.getRegionById(id);

      isLoading.value = false;

      if (response.code == 200) {
        regionData.value = response.data;
        regionData.refresh();

        message.value = "Data kantor berhasil dimuat.";
      } else {
        String errorMsg = response.message ?? "Data kantor gagal diambil. Silakan coba lagi.";
        message.value = errorMsg;
        CustomSnackbar(message: errorMsg, type: CustomSnackbarType.warning).show(context);
      }
    } catch (e) {
      isLoading.value = false;
      message.value = e.toString();
      CustomSnackbar(message: message.value, type: CustomSnackbarType.error).show(context);
    }
  }

  Future<void> getUserAm(BuildContext context, String regionId) async {
    if (isLoading.value) {
      return;
    }

    try {
      isLoading.value = true;
      message.value = '';

      final params = {
        'filter': {'role': UserRole.am.value, 'region_id': regionId},
      };

      final response = await userService.getAllUsers(params);

      isLoading.value = false;

      if (response.code == 200) {
        userAmData.value = response.data!.isNotEmpty ? response.data!.first : null;
        userAmData.refresh();

        message.value = "Data AM berhasil dimuat.";
      } else {
        String errorMsg = response.message ?? "Data AM gagal diambil. Silakan coba lagi.";
        message.value = errorMsg;
        CustomSnackbar(message: errorMsg, type: CustomSnackbarType.warning).show(context);
      }
    } catch (e) {
      isLoading.value = false;
      message.value = e.toString();
      CustomSnackbar(message: message.value, type: CustomSnackbarType.error).show(context);
    }
  }

  Future<void> getDashboardAm(BuildContext context) async {
    if (isLoading.value) {
      return;
    }

    try {
      isLoading.value = true;
      message.value = '';

      final params = {'format': selectedLoNasabahDisplayFilter.value};

      final response = await dashboardService.getDashboardAm(id: userAmData.value?.id ?? '', params: params);

      isLoading.value = false;

      if (response.code == 200) {
        dashboardAmData.value = response.data;
        totalWeekCurrentPeriod.value = dashboardAmData.value?.totalByWeek?.totalCurrentPeriod ?? 0;
        totalMonthCurrentPeriod.value = dashboardAmData.value?.totalByMonth?.totalCurrentPeriod ?? 0;
        totalWeekPercentageChange.value = dashboardAmData.value?.totalByWeek?.totalPercentageChange ?? 0.0;
        totalMonthPercentageChange.value = dashboardAmData.value?.totalByMonth?.totalPercentageChange ?? 0.0;
        dashboardAmData.refresh();

        message.value = "Data dashboard sudah dimuat.";
      } else {
        String errorMsg = response.message ?? "Data dashboard gagal diambil. Silakan coba lagi.";
        message.value = errorMsg;
        CustomSnackbar(message: errorMsg, type: CustomSnackbarType.warning).show(context);
      }
    } catch (e) {
      isLoading.value = false;
      message.value = e.toString();
      CustomSnackbar(message: message.value, type: CustomSnackbarType.error).show(context);
    }
  }
}
