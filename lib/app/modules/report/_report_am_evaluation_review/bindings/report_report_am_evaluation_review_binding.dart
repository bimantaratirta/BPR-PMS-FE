import 'package:get/get.dart';

import '../controllers/report_report_am_evaluation_review_controller.dart';

class ReportReportAmEvaluationReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportReportAmEvaluationReviewController>(
      () => ReportReportAmEvaluationReviewController(),
    );
  }
}
