import 'package:get/get.dart';

import '../controllers/lo_lo_detail_controller.dart';

class LoLoDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoLoDetailController>(
      () => LoLoDetailController(),
    );
  }
}
