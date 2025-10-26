import 'package:get/get.dart';

import '../controllers/office_office_detail_employee_lo_controller.dart';

class OfficeOfficeDetailEmployeeLoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfficeOfficeDetailEmployeeLoController>(
      () => OfficeOfficeDetailEmployeeLoController(),
    );
  }
}
