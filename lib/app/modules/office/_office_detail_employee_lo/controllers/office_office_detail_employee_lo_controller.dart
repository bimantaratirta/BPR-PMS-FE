import 'package:bpr_pms/app/data/modules/customer/customer_service.dart';
import 'package:bpr_pms/app/data/modules/customer/models/customer_model.dart';
import 'package:bpr_pms/app/data/modules/dashboard/dashboard_service.dart';
import 'package:bpr_pms/app/data/modules/dashboard/models/dashboard_lo_model.dart';
import 'package:bpr_pms/app/data/modules/user/models/user_model.dart';
import 'package:bpr_pms/app/data/modules/user/user_service.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfficeOfficeDetailEmployeeLoController extends GetxController {
  final UserService userService = UserService();
  final DashboardService dashboardService = DashboardService();
  final CustomerService customerService = CustomerService();

  RxString selectedLoNasabahDisplayFilter = 'minggu'.obs;
  Rx<List<Map<String, String>>> itemsSelectLoNasabahDisplayFilter = Rx<List<Map<String, String>>>([
    {"value": "minggu", "label": "Minggu"},
    {"value": "bulan", "label": "Bulan"},
  ]);

  final RxString id = ''.obs;
  final Rx<DashboardLoModel?> dashboardLoData = Rx<DashboardLoModel?>(null);
  final Rx<UserModel?> userData = Rx<UserModel?>(null);
  final Rx<List<CustomerModel>> customersData = Rx<List<CustomerModel>>([]);
  final isLoading = false.obs;
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
    getDashboardLo(Get.context!);
  }

  @override
  void onInit() {
    super.onInit();

    final String? itemId = Get.parameters['id'];

    if (itemId != null) {
      id.value = itemId;
      Future.microtask(() async {
        userData.value = await getUserById(Get.context!, itemId);
        await getAllCustomerByLo(Get.context!, itemId, isInitialLoad: true);
        await getDashboardLo(Get.context!);
      });
    }
  }

  Future<void> refreshData(BuildContext context) async {
    currentPage.value = 1;
    hasMoreData.value = true;
    customersData.value = [];
    await getAllCustomerByLo(context, id.value, isInitialLoad: true);
  }

  Future<void> getAllCustomerByLo(BuildContext context, String id, {bool isInitialLoad = false}) async {
    if ((isInitialLoad && isLoading.value) ||
        (!isInitialLoad && (isLoading.value || isPagingLoading.value || !hasMoreData.value))) {
      return;
    }

    try {
      if (isInitialLoad) {
        isLoading.value = true;
        message.value = '';
      } else {
        isPagingLoading.value = true;
      }

      final params = {
        'pagination': {'page': currentPage.value, 'limit': limit},
        'order_by': [
          {'field': 'created_at', 'direction': 'desc'},
        ],
      };

      final response = await customerService.getAllCustomerByLo(id: id, params: params);

      if (isInitialLoad) {
        isLoading.value = false;
      } else {
        isPagingLoading.value = false;
      }

      if (response.code == 200) {
        final newCustomers = response.data ?? [];

        if (currentPage.value == 1) {
          customersData.value = newCustomers;
        } else {
          customersData.value.addAll(newCustomers);
          customersData.refresh();
        }

        hasMoreData.value = newCustomers.length == limit;

        if (hasMoreData.value) {
          currentPage.value++;
        }

        message.value = isInitialLoad
            ? "Data nasabah berhasil diambil!"
            : newCustomers.isEmpty
            ? "Semua data nasabah sudah dimuat."
            : "Data nasabah halaman ${currentPage.value - 1} berhasil dimuat!";
      } else {
        String errorMsg = response.message ?? "Data nasabah gagal diambil. Silakan coba lagi.";
        message.value = errorMsg;
        hasMoreData.value = false;
        CustomSnackbar(message: errorMsg, type: CustomSnackbarType.warning).show(context);
      }
    } catch (e) {
      isLoading.value = false;
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

  Future<void> getDashboardLo(BuildContext context) async {
    if (isLoading.value) {
      return;
    }

    try {
      isLoading.value = true;
      message.value = '';

      final params = {'format': selectedLoNasabahDisplayFilter.value};

      final response = await dashboardService.getDashboardLo(id: userData.value?.id ?? '', params: params);

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
}
