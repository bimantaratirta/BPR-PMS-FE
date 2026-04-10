import 'package:bpr_pms/app/data/modules/auth/auth_service.dart';
import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bpr_pms/app/common/services/firebase_messaging_service.dart';
import 'package:flutter/foundation.dart';

class AuthLoginController extends GetxController {
  final AuthService authService = AuthService();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  void togglePasswordVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  final isLoading = false.obs;
  final RxString message = ''.obs;
  final RxMap<String, String> validationErrors = <String, String>{}.obs;
  final isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    usernameController.addListener(_updateFormValid);
    passwordController.addListener(_updateFormValid);
  }

  void _updateFormValid() {
    isFormValid.value = usernameController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future login(BuildContext context) async {
    try {
      validationErrors.clear();
      isLoading.value = true;
      message.value = '';

      final payload = {"username": usernameController.text, "password": passwordController.text};
      final response = await authService.login(payload);

      isLoading.value = false;

      if (response.code == 200) {
        message.value = "Login berhasil!";
        
        // Trigger save FCM token after successful login
        try {
          String? fcmToken = await FirebaseMessaging.instance.getToken();
          if (fcmToken != null) {
            await FirebaseMessagingService.saveFcmToken(fcmToken);
          }
        } catch (e) {
          if (kDebugMode) {
            print("Failed to save FCM token on login: $e");
          }
        }
        
        Get.offAllNamed(Routes.MAIN);
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

        isLoading.value = false;
      } else {
        String errorMsg = response.message ?? "Login gagal. Silakan coba lagi.";
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
