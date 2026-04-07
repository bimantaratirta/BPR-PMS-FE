import 'package:get/get.dart';

import '../controllers/nasabah_nasabah_create_controller.dart';

class NasabahNasabahCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NasabahNasabahCreateController>(
      () => NasabahNasabahCreateController(),
    );
  }
}
