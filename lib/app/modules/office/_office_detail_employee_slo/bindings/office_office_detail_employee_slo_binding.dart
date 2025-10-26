import 'package:get/get.dart';

import '../controllers/office_office_detail_employee_slo_controller.dart';

class OfficeOfficeDetailEmployeeSloBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfficeOfficeDetailEmployeeSloController>(
      () => OfficeOfficeDetailEmployeeSloController(),
    );
  }
}
