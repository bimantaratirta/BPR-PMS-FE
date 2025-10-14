import 'package:get/get.dart';

import '../controllers/report_report_slo_review_controller.dart';

class ReportReportSloReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportReportSloReviewController>(
      () => ReportReportSloReviewController(),
    );
  }
}
