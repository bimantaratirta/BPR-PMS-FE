import 'package:get/get.dart';

import '../controllers/report_report_slo_evaluation_controller.dart';

class ReportReportSloEvaluationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportReportSloEvaluationController>(
      () => ReportReportSloEvaluationController(),
    );
  }
}
