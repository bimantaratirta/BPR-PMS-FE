import 'package:get/get.dart';

import '../controllers/report_report_detail_controller.dart';

class ReportReportDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportReportDetailController>(
      () => ReportReportDetailController(),
    );
  }
}
