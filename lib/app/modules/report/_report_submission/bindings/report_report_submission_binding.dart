import 'package:get/get.dart';

import '../controllers/report_report_submission_controller.dart';

class ReportReportSubmissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportReportSubmissionController>(
      () => ReportReportSubmissionController(),
    );
  }
}
