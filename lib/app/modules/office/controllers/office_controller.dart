import 'package:bpr_pms/app/data/modules/region/models/region_model.dart';
import 'package:bpr_pms/app/data/modules/region/region_service.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfficeController extends GetxController {
  final RegionService regionService = RegionService();

  final Rx<List<RegionModel>> regionsData = Rx<List<RegionModel>>([]);
  final isLoading = false.obs;
  final RxString message = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getAllRegion(Get.context!);
  }

  Future<void> refreshData(BuildContext context) async {
    await getAllRegion(context);
  }

  Future<void> getAllRegion(BuildContext context) async {
    if (isLoading.value) {
      return;
    }

    try {
      isLoading.value = true;
      message.value = '';

      final response = await regionService.getAllRegion();

      isLoading.value = false;

      if (response.code == 200) {
        regionsData.value = response.data ?? [];
        regionsData.refresh();

        message.value = "Semua data kantor sudah dimuat.";
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
}
