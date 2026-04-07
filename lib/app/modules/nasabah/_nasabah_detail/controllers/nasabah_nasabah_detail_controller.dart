import 'package:bpr_pms/app/data/modules/customer/customer_service.dart';
import 'package:bpr_pms/app/data/modules/customer/models/customer_model.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NasabahNasabahDetailController extends GetxController {
  final CustomerService customerService = CustomerService();

  final RxString id = ''.obs;
  final isLoading = false.obs;
  final RxString message = ''.obs;
  final Rx<CustomerModel?> customerData = Rx<CustomerModel?>(null);
  var isHistoryExpanded = false.obs;

  void toggleHistoryExpansion() {
    isHistoryExpanded.value = !isHistoryExpanded.value;
  }

  Future<CustomerModel?> getCustomerById(BuildContext context, String id) async {
    try {
      isLoading.value = true;
      message.value = '';

      final response = await customerService.getCustomerById(id);

      isLoading.value = false;

      if (response.code == 200) {
        message.value = "Data nasabah berhasil diambil!";
        return response.data ?? null;
      } else {
        String errorMsg = response.message ?? "Data nasabah gagal diambil. Silakan coba lagi.";
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
