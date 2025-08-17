import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = Get.put(SplashScreenController());
    return Scaffold(body: SafeArea(child: Center(child: Image.asset(ImageAssets.logoBpr, scale: 8))));
  }
}
