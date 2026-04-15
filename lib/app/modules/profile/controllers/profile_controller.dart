import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:bpr_pms/app/modules/main/controllers/main_controller.dart';
import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final RxBool isRequestingLocation = false.obs;

  void handleLogout() async {
    final mainController = Get.find<MainController>();
    mainController.stopListeners();
    await authController.logout();
    Get.delete<MainController>(force: true);
    Get.offAllNamed(Routes.AUTH_LOGIN);
  }
}
