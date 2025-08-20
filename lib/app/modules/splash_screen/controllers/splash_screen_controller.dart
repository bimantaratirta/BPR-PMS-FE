import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    startSplashScreen();
  }

  void startSplashScreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.offAndToNamed(Routes.HOME);
    });
  }
}
