import 'package:get/get.dart';

import '../controllers/slo_controller.dart';

class SloBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SloController>(
      () => SloController(),
    );
  }
}
