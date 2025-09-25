import 'package:get/get.dart';

import '../controllers/nasabah_nasabah_create_report_controller.dart';

class NasabahNasabahCreateReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NasabahNasabahCreateReportController>(
      () => NasabahNasabahCreateReportController(),
    );
  }
}
