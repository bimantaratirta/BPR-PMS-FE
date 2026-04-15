import 'package:get/get.dart';

import '../controllers/employee_location_controller.dart';

class EmployeeLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeLocationController>(() => EmployeeLocationController());
  }
}
