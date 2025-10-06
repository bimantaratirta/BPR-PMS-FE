import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:bpr_pms/app/modules/main/controllers/main_controller.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final MainController mainController = Get.find<MainController>();

  void handleLogout() async {
    await authController.logout();
    mainController.changePage(AUTH_LOGIN_INDEX);
  }
}
