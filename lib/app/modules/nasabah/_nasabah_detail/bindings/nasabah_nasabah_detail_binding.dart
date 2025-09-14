import 'package:get/get.dart';

import '../controllers/nasabah_nasabah_detail_controller.dart';

class NasabahNasabahDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NasabahNasabahDetailController>(
      () => NasabahNasabahDetailController(),
    );
  }
}
