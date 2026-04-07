import 'package:bpr_pms/app/data/modules/auth/auth_service.dart';
import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileProfileDetailController extends GetxController {
  final AuthService authService = AuthService();

  final AuthController authController = Get.find<AuthController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController supervisorController = TextEditingController();
  final TextEditingController officeController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  final isLoading = false.obs;
  final RxString message = ''.obs;
  final RxMap<String, String> validationErrors = <String, String>{}.obs;
  final isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();

    nameController.addListener(_updateFormValid);
    usernameController.addListener(_updateFormValid);

    final user = authController.user.value;
    if (user != null) {
      nameController.text = user.name ?? '';
      usernameController.text = user.username ?? '';
      typeController.text = user.role ?? '';
      supervisorController.text = user.supervisor?.name ?? '';
      officeController.text = user.branch?.branch ?? '';
      districtController.text = user.region?.region ?? '';
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    usernameController.dispose();
    typeController.dispose();
    supervisorController.dispose();
    officeController.dispose();
    districtController.dispose();
    super.onClose();
  }

  void _updateFormValid() {
    isFormValid.value = usernameController.text.isNotEmpty && nameController.text.isNotEmpty;
  }

  Future updateProfile(BuildContext context) async {
    try {
      validationErrors.clear();
      isLoading.value = true;
      message.value = '';

      final payload = {"name": nameController.text, "username": usernameController.text};
      final response = await authService.updateProfile(payload);

      isLoading.value = false;

      if (response.code == 200) {
        message.value = "Profil berhasil diperbarui!";
        CustomSnackbar(message: message.value, type: CustomSnackbarType.success).show(context);
      } else if (response.code == 422) {
        Map<String, dynamic>? validationErrorsMap;
        if (response.errors is Map<String, dynamic> && response.errors['validation'] is Map<String, dynamic>) {
          validationErrorsMap = response.errors['validation'] as Map<String, dynamic>;

          validationErrorsMap.forEach((fieldKey, errorList) {
            if (fieldKey == 'branch_id' || fieldKey == 'region_id') {
              CustomSnackbar(message: errorList[0].toString(), type: CustomSnackbarType.warning).show(context);
            }
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

        isLoading.value = false;
      } else {
        String errorMsg = response.message ?? "Profile gagal diperbarui. Silakan coba lagi.";
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
