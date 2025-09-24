import 'package:get/get.dart';

import '../controllers/nasabah_nasabah_edit_controller.dart';

class NasabahNasabahEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NasabahNasabahEditController>(
      () => NasabahNasabahEditController(),
    );
  }
}
