import 'package:get/get.dart';

import '../controllers/profile_profile_change_password_controller.dart';

class ProfileProfileChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileProfileChangePasswordController>(
      () => ProfileProfileChangePasswordController(),
    );
  }
}
