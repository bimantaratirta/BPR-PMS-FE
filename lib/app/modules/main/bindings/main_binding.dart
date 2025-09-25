import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<MainController>(() => MainController(), fenix: true);
  }
}
