import 'package:bpr_pms/app/data/modules/customer/customer_service.dart';
import 'package:bpr_pms/app/data/modules/customer/models/customer_model.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NasabahController extends GetxController {
  final CustomerService customerService = CustomerService();

  final TextEditingController searchController = TextEditingController();

  final Rx<List<CustomerModel>> customersData = Rx<List<CustomerModel>>([]);
  final isLoading = false.obs;
  final RxString message = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getAllCustomer(Get.context!);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future getAllCustomer(BuildContext context) async {
    try {
      isLoading.value = true;
      message.value = '';

      final response = await customerService.getAllCustomer();

      isLoading.value = false;

      if (response.code == 200) {
        customersData.value = response.data ?? [];
        message.value = "Data nasabah berhasil diambil!";
      } else {
        String errorMsg = response.message ?? "Data nasabah gagal diambil. Silakan coba lagi.";
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
