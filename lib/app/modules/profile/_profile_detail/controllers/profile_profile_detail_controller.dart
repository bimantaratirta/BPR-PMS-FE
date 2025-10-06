import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileProfileDetailController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController supervisorController = TextEditingController();
  final TextEditingController officeController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
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
}
