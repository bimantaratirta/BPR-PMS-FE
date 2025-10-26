part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const AUTH_LOGIN = _Paths.AUTH + _Paths.LOGIN;
  static const AUTH_REGISTER = _Paths.AUTH + _Paths.REGISTER;
  static const MAIN = _Paths.MAIN;
  static const PROFILE = _Paths.PROFILE;
  static const NASABAH = _Paths.NASABAH;
  static const REPORT = _Paths.REPORT;
  static const LO = _Paths.LO;
  static const SLO = _Paths.SLO;
  static const OFFICE = _Paths.OFFICE;

  // Nasabah Nested Routes
  static String nasabahDetail(String id) => '${_Paths.MAIN}${_Paths.NASABAH}/$id';
  static String nasabahEdit(String id) => '${_Paths.MAIN}${_Paths.NASABAH}/$id/edit';
  static String nasabahReport(String id) => '${_Paths.MAIN}${_Paths.NASABAH}/$id/report';
  static String nasabahCreate() => '${_Paths.MAIN}${_Paths.NASABAH}/create';

  // Profile Nested Routes
  static String profileDetail() => '${_Paths.MAIN}${_Paths.PROFILE}/detail';
  static String profileChangePassword() => '${_Paths.MAIN}${_Paths.PROFILE}/change-password';

  // Report Nested Routes
  static String reportDetail(String id) => '${_Paths.MAIN}${_Paths.REPORT}/$id';
  static String reportSloReview(String id) => '${_Paths.MAIN}${_Paths.REPORT}/$id/slo-review';
  static String reportSloEvaluation(String id) => '${_Paths.MAIN}${_Paths.REPORT}/$id/slo-evaluation';
  static String reportAmEvaluationReview(String id) => '${_Paths.MAIN}${_Paths.REPORT}/$id/am-evaluation-review';

  // LO Nested Routes
  static String loDetail(String id) => '${_Paths.MAIN}${_Paths.LO}/$id';

  // SLO Nested Routes
  static String sloDetail(String id) => '${_Paths.MAIN}${_Paths.SLO}/$id';

  // Office Nested Routes
  static String officeDetail(String id) => '${_Paths.MAIN}${_Paths.OFFICE}/$id';
  static String officeDetailEmployee(String id) => '${_Paths.MAIN}${_Paths.OFFICE}/$id/employee';
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const SPLASH_SCREEN = '/splash-screen';
  static const AUTH = '/auth';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const MAIN = '/main';
  static const PROFILE = '/profile';
  static const NASABAH = '/nasabah';
  static const REPORT = '/report';
  static const LO = '/lo';
  static const SLO = '/slo';
  static const OFFICE = '/office';
}
