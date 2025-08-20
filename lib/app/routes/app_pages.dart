import 'package:get/get.dart';

import '../modules/auth/login/bindings/auth_login_binding.dart';
import '../modules/auth/login/views/auth_login_view.dart';
import '../modules/auth/register/bindings/auth_register_binding.dart';
import '../modules/auth/register/views/auth_register_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
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
  ];
}
