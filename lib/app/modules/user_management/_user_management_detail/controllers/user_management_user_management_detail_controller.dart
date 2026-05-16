import 'package:bpr_pms/app/data/modules/user/models/user_model.dart';
import 'package:bpr_pms/app/data/modules/user/user_service.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserManagementUserManagementDetailController extends GetxController {
  final UserService userService = UserService();

  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final isLoading = false.obs;
  final RxString id = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final String? itemId = Get.parameters['id'];
    if (itemId != null) {
      id.value = itemId;
      Future.microtask(() => fetch(Get.context!));
    }
  }

  Future<void> fetch(BuildContext context) async {
    isLoading.value = true;
    final response = await userService.getUserById(id.value);
    isLoading.value = false;
    if (response.code == 200) {
      user.value = response.data;
    } else {
      CustomSnackbar(
        message: response.message ?? 'Gagal memuat user',
        type: CustomSnackbarType.error,
      ).show(context);
    }
  }
}
