import 'package:get/get.dart';

import '../modules/auth/login/bindings/auth_login_binding.dart';
import '../modules/auth/login/views/auth_login_view.dart';
import '../modules/auth/register/bindings/auth_register_binding.dart';
import '../modules/auth/register/views/auth_register_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/nasabah/bindings/nasabah_binding.dart';
import '../modules/nasabah/views/nasabah_view.dart';
import '../modules/profile/_profile_change_password/bindings/profile_profile_change_password_binding.dart';
import '../modules/profile/_profile_change_password/views/profile_profile_change_password_view.dart';
import '../modules/profile/_profile_detail/bindings/profile_profile_detail_binding.dart';
import '../modules/profile/_profile_detail/views/profile_profile_detail_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/report/bindings/report_binding.dart';
import '../modules/report/views/report_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(name: _Paths.HOME, page: () => const HomeView(), binding: HomeBinding()),
    GetPage(name: _Paths.SPLASH_SCREEN, page: () => const SplashScreenView(), binding: SplashScreenBinding()),
    GetPage(name: _Paths.AUTH + _Paths.LOGIN, page: () => const AuthLoginView(), binding: AuthLoginBinding()),
    GetPage(name: _Paths.AUTH + _Paths.REGISTER, page: () => const AuthRegisterView(), binding: AuthRegisterBinding()),
    GetPage(name: _Paths.MAIN, page: () => const MainView(), binding: MainBinding()),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      children: [
        GetPage(
          name: _Paths.PROFILE_PROFILE_CHANGE_PASSWORD,
          page: () => const ProfileProfileChangePasswordView(),
          binding: ProfileProfileChangePasswordBinding(),
        ),
        GetPage(
          name: _Paths.PROFILE_PROFILE_DETAIL,
          page: () => const ProfileProfileDetailView(),
          binding: ProfileProfileDetailBinding(),
        ),
      ],
    ),
    GetPage(name: _Paths.NASABAH, page: () => const NasabahView(), binding: NasabahBinding()),
    GetPage(name: _Paths.REPORT, page: () => const ReportView(), binding: ReportBinding()),
  ];
}
