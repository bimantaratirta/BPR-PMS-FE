import 'package:bpr_pms/app/data/modules/region/models/region_model.dart';
import 'package:bpr_pms/app/data/modules/region/region_service.dart';
import 'package:bpr_pms/app/modules/office/widgets/create_office_dialog_content.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:bpr_pms/app/widgets/dialog/build_custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OfficeController extends GetxController {
  final RegionService regionService = RegionService();

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  final Rx<List<RegionModel>> regionsData = Rx<List<RegionModel>>([]);
  final isLoading = false.obs;
  final isCreateRegionLoading = false.obs;
  final RxString message = ''.obs;
  final RxMap<String, String> validationErrors = <String, String>{}.obs;

  List<RegionModel> get filteredRegionsData {
    if (searchQuery.value.isEmpty) {
      return regionsData.value;
    } else {
      final query = searchQuery.value.toLowerCase();
      return regionsData.value.where((region) {
        final regionName = region.region?.toLowerCase() ?? '';
        return regionName.contains(query);
      }).toList();
    }
  }

  @override
  void onInit() {
    super.onInit();

    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });

    getAllRegion(Get.context!);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void showCreateOfficeDialog(BuildContext context) {
    BuildCustomDialog.show(
      context: context,
      content: CreateOfficeDialogContent(),
      height: null,
      width: Get.size.width * 0.85,
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 24.h),
      borderRadius: 15,
    );
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

  Future createRegion(BuildContext context, String name) async {
    try {
      validationErrors.clear();
      isCreateRegionLoading.value = true;
      message.value = '';

      final payload = {"region": name};

      final response = await regionService.createRegion(payload);

      isCreateRegionLoading.value = false;

      if (response.code == 201 || response.code == 200) {
        message.value = "Region berhasil dibuat!";
        CustomSnackbar(message: message.value, type: CustomSnackbarType.success).show(context);
        Get.back();
        await refreshData(context);
      } else if (response.code == 422) {
        Map<String, dynamic>? validationErrorsMap;

        if (response.errors is Map<String, dynamic> && response.errors['validation'] is Map<String, dynamic>) {
          validationErrorsMap = response.errors['validation'] as Map<String, dynamic>;

          validationErrorsMap.forEach((fieldKey, errorList) {
            if (errorList is List && errorList.isNotEmpty) {
              validationErrors[fieldKey] = errorList[0].toString();
            }
          });

          validationErrors.refresh();
          message.value = 'Validasi gagal. Periksa input Anda.';
        } else if (response.error != null) {
          message.value = response.error.toString();
        } else {
          message.value = 'Validasi gagal. Periksa input Anda.';
        }

        CustomSnackbar(
          message: response.message ?? "Validasi gagal. Periksa input Anda.",
          type: CustomSnackbarType.warning,
        ).show(context);
        isCreateRegionLoading.value = false;
      } else {
        String errorMsg = response.message ?? "Region gagal dibuat. Silakan coba lagi.";
        message.value = errorMsg;
        CustomSnackbar(message: errorMsg, type: CustomSnackbarType.warning).show(context);
      }
    } catch (e) {
      isCreateRegionLoading.value = false;
      message.value = e.toString();
      CustomSnackbar(message: message.value, type: CustomSnackbarType.error).show(context);
    }
  }
}
