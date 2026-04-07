import 'package:get/get.dart';

import '../controllers/profile_profile_detail_controller.dart';

class ProfileProfileDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileProfileDetailController>(
      () => ProfileProfileDetailController(),
    );
  }
}
