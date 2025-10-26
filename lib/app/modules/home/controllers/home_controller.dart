import 'package:bpr_pms/app/data/modules/dashboard/dashboard_service.dart';
import 'package:bpr_pms/app/data/modules/dashboard/models/dashboard_am_model.dart';
import 'package:bpr_pms/app/data/modules/dashboard/models/dashboard_direksi_model.dart';
import 'package:bpr_pms/app/data/modules/dashboard/models/dashboard_lo_model.dart';
import 'package:bpr_pms/app/data/modules/dashboard/models/dashboard_slo_model.dart';
import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final DashboardService dashboardService = DashboardService();
  final AuthController authController = Get.find<AuthController>();

  final Rx<DashboardLoModel?> dashboardLoData = Rx<DashboardLoModel?>(null);
  final Rx<DashboardSloModel?> dashboardSloData = Rx<DashboardSloModel?>(null);
  final Rx<DashboardAmModel?> dashboardAmData = Rx<DashboardAmModel?>(null);
  final Rx<DashboardDireksiModel?> dashboardDireksiData = Rx<DashboardDireksiModel?>(null);
  final isLoading = false.obs;
  final RxString message = ''.obs;
  final RxInt totalWeekCurrentPeriod = 0.obs;
  final RxInt totalMonthCurrentPeriod = 0.obs;
  final RxDouble totalWeekPercentageChange = 0.0.obs;
  final RxDouble totalMonthPercentageChange = 0.0.obs;

  RxString selectedLoNasabahDisplayFilter = 'minggu'.obs;
  Rx<List<Map<String, String>>> itemsSelectLoNasabahDisplayFilter = Rx<List<Map<String, String>>>([
    {"value": "minggu", "label": "Minggu"},
    {"value": "bulan", "label": "Bulan"},
  ]);

  final RxList<Map<String, dynamic>> loNasabahChartData = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> sloNasabahChartData = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> regionNasabahChartData = <Map<String, dynamic>>[].obs;

  void changeSelectedLoNasabahDisplayFilter(String value) {
    selectedLoNasabahDisplayFilter.value = value;
    if (authController.pickRole.value == UserRole.lo) {
      getDashboardLo(Get.context!);
    } else if (authController.pickRole.value == UserRole.slo) {
      getDashboardSlo(Get.context!);
    } else if (authController.pickRole.value == UserRole.am) {
      getDashboardAm(Get.context!);
    } else if (authController.pickRole.value == UserRole.direksi) {
      getDashboardDireksi(Get.context!);
    }
  }

  @override
  void onInit() {
    super.onInit();

    ever(dashboardSloData, _updateLoNasabahChart);
    ever(dashboardAmData, _updateSloNasabahChart);
    ever(dashboardDireksiData, _updateRegionNasabahChart);

    if (authController.pickRole.value == UserRole.lo) {
      getDashboardLo(Get.context!);
    } else if (authController.pickRole.value == UserRole.slo) {
      getDashboardSlo(Get.context!);
    } else if (authController.pickRole.value == UserRole.am) {
      getDashboardAm(Get.context!);
    } else if (authController.pickRole.value == UserRole.direksi) {
      getDashboardDireksi(Get.context!);
    }
  }

  void _updateLoNasabahChart(DashboardSloModel? data) {
    if (data == null) {
      loNasabahChartData.clear();
      return;
    }

    final List<Map<String, dynamic>> transformedList =
        data.loReports?.map((item) {
          return <String, dynamic>{
            'label': item.loName,
            'value': selectedLoNasabahDisplayFilter.value == 'minggu'
                ? item.currentPeriodReportsWeek
                : item.currentPeriodReportsMonth,
          };
        }).toList() ??
        <Map<String, dynamic>>[];

    loNasabahChartData.assignAll(transformedList);
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

  void _updateRegionNasabahChart(DashboardDireksiModel? data) {
    if (data == null) {
      regionNasabahChartData.clear();
      return;
    }

    final List<Map<String, dynamic>> transformedList =
        data.amReports?.map((item) {
          return <String, dynamic>{
            'label': item.region,
            'value': selectedLoNasabahDisplayFilter.value == 'minggu'
                ? item.currentPeriodReportsWeek
                : item.currentPeriodReportsMonth,
          };
        }).toList() ??
        <Map<String, dynamic>>[];

    regionNasabahChartData.assignAll(transformedList);
  }

  Future<void> getDashboardLo(BuildContext context) async {
    if (isLoading.value) {
      return;
    }

    try {
      isLoading.value = true;
      message.value = '';

      final params = {'format': selectedLoNasabahDisplayFilter.value};

      final response = await dashboardService.getDashboardLo(id: authController.user.value?.id ?? '', params: params);

      isLoading.value = false;

      if (response.code == 200) {
        dashboardLoData.value = response.data;
        totalWeekCurrentPeriod.value = dashboardLoData.value?.totalByWeek?.totalCurrentPeriod ?? 0;
        totalMonthCurrentPeriod.value = dashboardLoData.value?.totalByMonth?.totalCurrentPeriod ?? 0;
        totalWeekPercentageChange.value = dashboardLoData.value?.totalByWeek?.totalPercentageChange ?? 0.0;
        totalMonthPercentageChange.value = dashboardLoData.value?.totalByMonth?.totalPercentageChange ?? 0.0;
        dashboardLoData.refresh();

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

  Future<void> getDashboardSlo(BuildContext context) async {
    if (isLoading.value) {
      return;
    }

    try {
      isLoading.value = true;
      message.value = '';

      final params = {'format': selectedLoNasabahDisplayFilter.value};

      final response = await dashboardService.getDashboardSlo(id: authController.user.value?.id ?? '', params: params);

      isLoading.value = false;

      if (response.code == 200) {
        dashboardSloData.value = response.data;
        totalWeekCurrentPeriod.value = dashboardSloData.value?.totalByWeek?.totalCurrentPeriod ?? 0;
        totalMonthCurrentPeriod.value = dashboardSloData.value?.totalByMonth?.totalCurrentPeriod ?? 0;
        totalWeekPercentageChange.value = dashboardSloData.value?.totalByWeek?.totalPercentageChange ?? 0.0;
        totalMonthPercentageChange.value = dashboardSloData.value?.totalByMonth?.totalPercentageChange ?? 0.0;
        dashboardSloData.refresh();

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

  Future<void> getDashboardAm(BuildContext context) async {
    if (isLoading.value) {
      return;
    }

    try {
      isLoading.value = true;
      message.value = '';

      final params = {'format': selectedLoNasabahDisplayFilter.value};

      final response = await dashboardService.getDashboardAm(id: authController.user.value?.id ?? '', params: params);

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

  Future<void> getDashboardDireksi(BuildContext context) async {
    if (isLoading.value) {
      return;
    }

    try {
      isLoading.value = true;
      message.value = '';

      final params = {'format': selectedLoNasabahDisplayFilter.value};

      final response = await dashboardService.getDashboardDireksi(params);

      isLoading.value = false;

      if (response.code == 200) {
        dashboardDireksiData.value = response.data;
        totalWeekCurrentPeriod.value = dashboardDireksiData.value?.totalByWeek?.totalCurrentPeriod ?? 0;
        totalMonthCurrentPeriod.value = dashboardDireksiData.value?.totalByMonth?.totalCurrentPeriod ?? 0;
        totalWeekPercentageChange.value = dashboardDireksiData.value?.totalByWeek?.totalPercentageChange ?? 0.0;
        totalMonthPercentageChange.value = dashboardDireksiData.value?.totalByMonth?.totalPercentageChange ?? 0.0;
        dashboardDireksiData.refresh();

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
