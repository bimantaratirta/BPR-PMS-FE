import 'package:bpr_pms/app/data/modules/customer/customer_service.dart';
import 'package:bpr_pms/app/data/modules/customer/models/customer_model.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NasabahController extends GetxController {
  final CustomerService customerService = CustomerService();

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

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
    getAllCustomer(Get.context!, isInitialLoad: true);

    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });

    debounce(searchQuery, (_) async {
      currentPage.value = 1;
      hasMoreData.value = true;
      customersData.value = [];
      await getAllCustomer(Get.context!, isInitialLoad: true);
    }, time: const Duration(milliseconds: 1000));
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> refreshData(BuildContext context) async {
    currentPage.value = 1;
    hasMoreData.value = true;
    customersData.value = [];
    await getAllCustomer(context, isInitialLoad: true);
  }

  Future<void> getAllCustomer(BuildContext context, {bool isInitialLoad = false}) async {
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
        'search': searchController.text.trim(),
        'pagination': {'page': currentPage.value, 'limit': limit},
      };

      final response = await customerService.getAllCustomer(params);

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
}
