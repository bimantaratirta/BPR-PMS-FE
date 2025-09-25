import 'package:get/get.dart';

import '../modules/auth/login/bindings/auth_login_binding.dart';
import '../modules/auth/login/views/auth_login_view.dart';
import '../modules/auth/register/bindings/auth_register_binding.dart';
import '../modules/auth/register/views/auth_register_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/lo/bindings/lo_binding.dart';
import '../modules/lo/views/lo_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/nasabah/_nasabah_create/bindings/nasabah_nasabah_create_binding.dart';
import '../modules/nasabah/_nasabah_create/views/nasabah_nasabah_create_view.dart';
import '../modules/nasabah/_nasabah_create_report/bindings/nasabah_nasabah_create_report_binding.dart';
import '../modules/nasabah/_nasabah_create_report/views/nasabah_nasabah_create_report_view.dart';
import '../modules/nasabah/_nasabah_detail/bindings/nasabah_nasabah_detail_binding.dart';
import '../modules/nasabah/_nasabah_detail/views/nasabah_nasabah_detail_view.dart';
import '../modules/nasabah/_nasabah_edit/bindings/nasabah_nasabah_edit_binding.dart';
import '../modules/nasabah/_nasabah_edit/views/nasabah_nasabah_edit_view.dart';
import '../modules/nasabah/bindings/nasabah_binding.dart';
import '../modules/nasabah/views/nasabah_view.dart';
import '../modules/profile/_profile_change_password/bindings/profile_profile_change_password_binding.dart';
import '../modules/profile/_profile_change_password/views/profile_profile_change_password_view.dart';
import '../modules/profile/_profile_detail/bindings/profile_profile_detail_binding.dart';
import '../modules/profile/_profile_detail/views/profile_profile_detail_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/report/_report_detail/bindings/report_report_detail_binding.dart';
import '../modules/report/_report_detail/views/report_report_detail_view.dart';
import '../modules/report/bindings/report_binding.dart';
import '../modules/report/views/report_view.dart';
import '../modules/slo/bindings/slo_binding.dart';
import '../modules/slo/views/slo_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        binding: HomeBinding()),
    GetPage(
        name: _Paths.SPLASH_SCREEN,
        page: () => const SplashScreenView(),
        binding: SplashScreenBinding()),
    GetPage(
        name: _Paths.AUTH + _Paths.LOGIN,
        page: () => const AuthLoginView(),
        binding: AuthLoginBinding()),
    GetPage(
        name: _Paths.AUTH + _Paths.REGISTER,
        page: () => const AuthRegisterView(),
        binding: AuthRegisterBinding()),
    GetPage(
        name: _Paths.MAIN,
        page: () => const MainView(),
        binding: MainBinding()),
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
    GetPage(
      name: _Paths.NASABAH,
      page: () => const NasabahView(),
      binding: NasabahBinding(),
      children: [
        GetPage(
          name: _Paths.NASABAH_NASABAH_DETAIL,
          page: () => const NasabahNasabahDetailView(),
          binding: NasabahNasabahDetailBinding(),
        ),
        GetPage(
          name: _Paths.NASABAH_NASABAH_CREATE,
          page: () => const NasabahNasabahCreateView(),
          binding: NasabahNasabahCreateBinding(),
        ),
        GetPage(
          name: _Paths.NASABAH_NASABAH_CREATE_REPORT,
          page: () => const NasabahNasabahCreateReportView(),
          binding: NasabahNasabahCreateReportBinding(),
        ),
        GetPage(
          name: _Paths.NASABAH_NASABAH_EDIT,
          page: () => const NasabahNasabahEditView(),
          binding: NasabahNasabahEditBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => const ReportView(),
      binding: ReportBinding(),
      children: [
        GetPage(
          name: _Paths.REPORT_REPORT_DETAIL,
          page: () => const ReportReportDetailView(),
          binding: ReportReportDetailBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LO,
      page: () => const LoView(),
      binding: LoBinding(),
    ),
    GetPage(
      name: _Paths.SLO,
      page: () => const SloView(),
      binding: SloBinding(),
    ),
  ];
}
