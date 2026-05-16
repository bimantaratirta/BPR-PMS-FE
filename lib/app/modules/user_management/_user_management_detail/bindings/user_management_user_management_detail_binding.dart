import 'package:get/get.dart';

import '../controllers/user_management_user_management_detail_controller.dart';

class UserManagementUserManagementDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserManagementUserManagementDetailController>(
      () => UserManagementUserManagementDetailController(),
    );
  }
}
