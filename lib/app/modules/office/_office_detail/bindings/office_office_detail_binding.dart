import 'package:get/get.dart';

import '../controllers/office_office_detail_controller.dart';

class OfficeOfficeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfficeOfficeDetailController>(
      () => OfficeOfficeDetailController(),
    );
  }
}
