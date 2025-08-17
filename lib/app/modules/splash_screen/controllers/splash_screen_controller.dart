import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    startSplashScreen();
  }

  void startSplashScreen() {
    Future.delayed(Duration(seconds: 5), () async {
      Get.offAndToNamed(Routes.HOME);
    });
  }
}
