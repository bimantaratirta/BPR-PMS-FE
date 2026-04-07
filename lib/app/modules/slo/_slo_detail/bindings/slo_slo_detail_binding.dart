import 'package:get/get.dart';

import '../controllers/slo_slo_detail_controller.dart';

class SloSloDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SloSloDetailController>(
      () => SloSloDetailController(),
    );
  }
}
