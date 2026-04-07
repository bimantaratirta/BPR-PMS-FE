import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:bpr_pms/app/modules/main/controllers/main_controller.dart';
import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:bpr_pms/app/data/modules/location/location_service.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final LocationService _locationService = LocationService();
  final RxBool isRequestingLocation = false.obs;

  Future<void> requestAllLocation() async {
    isRequestingLocation.value = true;
    
    final response = await _locationService.requestAllLocation();
    
    isRequestingLocation.value = false;
    Get.back(); // Close dialog

    if (response.status == 'success' || (response.code != null && response.code! >= 200 && response.code! < 300)) {
      CustomSnackbar(message: "Berhasil meminta lokasi semua pengguna", type: CustomSnackbarType.success).show(Get.context!);
    } else {
      CustomSnackbar(message: response.message ?? "Gagal meminta lokasi", type: CustomSnackbarType.error).show(Get.context!);
    }
  }

  void handleLogout() async {
    final mainController = Get.find<MainController>();
    mainController.stopListeners();
    await authController.logout();
    Get.delete<MainController>(force: true);
    Get.offAllNamed(Routes.AUTH_LOGIN);
  }
}
