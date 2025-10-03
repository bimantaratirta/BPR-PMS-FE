import 'package:bpr_pms/app/data/modules/user/models/user_model.dart';
import 'package:get/get.dart';

enum UserRole {
  lo(value: "LO"),
  slo(value: "SLO"),
  am(value: "AM");

  final String value;

  const UserRole({required this.value});

  static UserRole? fromString(String? roleString) {
    if (roleString == null) return null;
    try {
      return UserRole.values.firstWhere((e) => e.value.toUpperCase() == roleString.toUpperCase());
    } catch (e) {
      return null;
    }
  }
}

class AuthController extends GetxController {
  Rx<UserModel?> user = Rx<UserModel?>(null);
  Rx<List<UserRole>> roles = Rx<List<UserRole>>([UserRole.lo, UserRole.slo, UserRole.am]);
  Rx<UserRole?> pickRole = Rx<UserRole?>(UserRole.am);

  void changePickRole(UserRole? value) {
    pickRole.value = value;
  }
}
