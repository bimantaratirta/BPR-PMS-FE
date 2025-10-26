import 'package:bpr_pms/app/data/modules/customer/customer_service.dart';
import 'package:bpr_pms/app/data/modules/customer/models/customer_model.dart';
import 'package:bpr_pms/app/data/modules/user/models/user_model.dart';
import 'package:bpr_pms/app/data/modules/user/user_service.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoLoDetailController extends GetxController {
  final UserService userService = UserService();
  final CustomerService customerService = CustomerService();

  final RxString id = ''.obs;
  final Rx<UserModel?> userData = Rx<UserModel?>(null);
  final Rx<List<CustomerModel>> customersData = Rx<List<CustomerModel>>([]);
  final isLoading = false.obs;
  final RxString message = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMoreData = true.obs;
  final int limit = 5;
  final isPagingLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final String? itemId = Get.parameters['id'];

    if (itemId != null) {
      id.value = itemId;
      Future.microtask(() async {
        userData.value = await getUserById(Get.context!, itemId);
        await getAllCustomerByLo(Get.context!, itemId, isInitialLoad: true);
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
}
