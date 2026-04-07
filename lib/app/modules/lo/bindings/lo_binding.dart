import 'package:get/get.dart';

import '../controllers/lo_controller.dart';

class LoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoController>(
      () => LoController(),
    );
  }
}
