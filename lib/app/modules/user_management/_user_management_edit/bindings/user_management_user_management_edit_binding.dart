import 'package:get/get.dart';

import '../controllers/user_management_user_management_edit_controller.dart';

class UserManagementUserManagementEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserManagementUserManagementEditController>(
      () => UserManagementUserManagementEditController(),
    );
  }
}
