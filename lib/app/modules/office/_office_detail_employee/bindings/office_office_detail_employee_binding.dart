import 'package:get/get.dart';

import '../controllers/office_office_detail_employee_controller.dart';

class OfficeOfficeDetailEmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfficeOfficeDetailEmployeeController>(
      () => OfficeOfficeDetailEmployeeController(),
    );
  }
}
