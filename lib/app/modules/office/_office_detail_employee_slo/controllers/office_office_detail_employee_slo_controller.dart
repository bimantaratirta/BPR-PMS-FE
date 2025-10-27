import 'package:bpr_pms/app/data/modules/dashboard/dashboard_service.dart';
import 'package:bpr_pms/app/data/modules/dashboard/models/dashboard_slo_model.dart';
import 'package:bpr_pms/app/data/modules/user/models/user_model.dart';
import 'package:bpr_pms/app/data/modules/user/user_service.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfficeOfficeDetailEmployeeSloController extends GetxController {
  final UserService userService = UserService();
  final DashboardService dashboardService = DashboardService();

  RxString selectedLoNasabahDisplayFilter = 'minggu'.obs;
  Rx<List<Map<String, String>>> itemsSelectLoNasabahDisplayFilter = Rx<List<Map<String, String>>>([
    {"value": "minggu", "label": "Minggu"},
    {"value": "bulan", "label": "Bulan"},
  ]);

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  final RxString id = ''.obs;
  final Rx<DashboardSloModel?> dashboardSloData = Rx<DashboardSloModel?>(null);
  final Rx<UserModel?> userData = Rx<UserModel?>(null);
  final Rx<List<UserModel>> usersLoData = Rx<List<UserModel>>([]);
  final isLoading = false.obs;
  final isGetUsersLoLoading = false.obs;
  final RxString message = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMoreData = true.obs;
  final int limit = 5;
  final isPagingLoading = false.obs;
  final RxInt totalWeekCurrentPeriod = 0.obs;
  final RxInt totalMonthCurrentPeriod = 0.obs;
  final RxDouble totalWeekPercentageChange = 0.0.obs;
  final RxDouble totalMonthPercentageChange = 0.0.obs;
  final RxList<Map<String, dynamic>> loNasabahChartData = <Map<String, dynamic>>[].obs;

  void changeSelectedLoNasabahDisplayFilter(String value) {
    selectedLoNasabahDisplayFilter.value = value;
    getDashboardSlo(Get.context!);
  }

  @override
  void onInit() {
    super.onInit();
    ever(dashboardSloData, _updateLoNasabahChart);

    final String? itemId = Get.parameters['id'];

    if (itemId != null) {
      id.value = itemId;
      Future.microtask(() async {
        userData.value = await getUserById(Get.context!, itemId);
        await getAllLoBySlo(Get.context!, itemId, isInitialLoad: true);
        await getDashboardSlo(Get.context!);
      });
    }

    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });

    debounce(searchQuery, (_) async {
      currentPage.value = 1;
      hasMoreData.value = true;
      usersLoData.value = [];
      await getAllLoBySlo(Get.context!, id.value, isInitialLoad: true);
    }, time: const Duration(milliseconds: 1000));
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

  Future<void> refreshData(BuildContext context) async {
    currentPage.value = 1;
    hasMoreData.value = true;
    usersLoData.value = [];
    await getAllLoBySlo(context, id.value, isInitialLoad: true);
  }

  Future<void> getAllLoBySlo(BuildContext context, String id, {bool isInitialLoad = false}) async {
    if ((isInitialLoad && isLoading.value && isGetUsersLoLoading.value) ||
        (!isInitialLoad && (isLoading.value || isPagingLoading.value || !hasMoreData.value || isGetUsersLoLoading.value))) {
      return;
    }

    try {
      if (isInitialLoad) {
        isGetUsersLoLoading.value = true;
        message.value = '';
      } else {
        isPagingLoading.value = true;
      }

      final params = {
        'pagination': {'page': currentPage.value, 'limit': limit},
        'search': searchController.text.trim(),
      };

      final response = await userService.getAllLoBySlo(id: id, params: params);

      if (isInitialLoad) {
        isGetUsersLoLoading.value = false;
      } else {
        isPagingLoading.value = false;
      }

      if (response.code == 200) {
        final newUsersLo = response.data ?? [];

        if (currentPage.value == 1) {
          usersLoData.value = newUsersLo;
        } else {
          usersLoData.value.addAll(newUsersLo);
          usersLoData.refresh();
        }

        hasMoreData.value = newUsersLo.length == limit;

        if (hasMoreData.value) {
          currentPage.value++;
        }

        message.value = isInitialLoad
            ? "Data user lo berhasil diambil!"
            : newUsersLo.isEmpty
            ? "Semua data user lo sudah dimuat."
            : "Data user lo halaman ${currentPage.value - 1} berhasil dimuat!";
      } else {
        String errorMsg = response.message ?? "Data user lo gagal diambil. Silakan coba lagi.";
        message.value = errorMsg;
        hasMoreData.value = false;
        CustomSnackbar(message: errorMsg, type: CustomSnackbarType.warning).show(context);
      }
    } catch (e) {
      isGetUsersLoLoading.value = false;
      isPagingLoading.value = false;
      hasMoreData.value = false;
      message.value = e.toString();
      CustomSnackbar(message: message.value, type: CustomSnackbarType.error).show(context);
    }
  }

  Future<UserModel?> getUserById(BuildContext context, String id) async {
    try {
      isLoading.value = true;
      message.value = '';

      final response = await userService.getUserById(id);

      isLoading.value = false;

      if (response.code == 200) {
        message.value = "Data pengguna berhasil diambil!";
        userData.value = response.data;
        return response.data;
      } else {
        String errorMsg = response.message ?? "Data pengguna gagal diambil. Silakan coba lagi.";
        message.value = errorMsg;
        CustomSnackbar(message: errorMsg, type: CustomSnackbarType.warning).show(context);
        return null;
      }
    } catch (e) {
      isLoading.value = false;
      message.value = e.toString();
      CustomSnackbar(message: message.value, type: CustomSnackbarType.error).show(context);
      return null;
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

      final response = await dashboardService.getDashboardSlo(id: userData.value?.id ?? '', params: params);

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
}
