import 'package:get/get.dart';

import '../controllers/user_management_user_management_create_controller.dart';

class UserManagementUserManagementCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserManagementUserManagementCreateController>(
      () => UserManagementUserManagementCreateController(),
    );
  }
}
