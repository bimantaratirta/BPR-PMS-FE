import 'package:get/get.dart';

enum UserRole { lo, slo, am }

class AuthController extends GetxController {
  Rx<List<UserRole>> roles = Rx<List<UserRole>>([UserRole.lo, UserRole.slo, UserRole.am]);
  Rx<UserRole?> pickRole = Rx<UserRole?>(UserRole.am);

  void changePickRole(UserRole? value) {
    pickRole.value = value;
  }
}
