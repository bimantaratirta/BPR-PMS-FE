import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/dashboard/dashboard_repository.dart';
import 'package:bpr_pms/app/data/modules/dashboard/models/dashboard_am_model.dart';
import 'package:bpr_pms/app/data/modules/dashboard/models/dashboard_direksi_model.dart';
import 'package:bpr_pms/app/data/modules/dashboard/models/dashboard_lo_model.dart';
import 'package:bpr_pms/app/data/modules/dashboard/models/dashboard_slo_model.dart';

class DashboardService {
  final DashboardRepository _dashboardRepository = DashboardRepository();
  final Helper helper = Helper();

  Future<ApiResponseModel<DashboardLoModel>> getDashboardLo({required String id, Map<String, dynamic>? params}) async {
    try {
      final Map<String, dynamic> queryParams = params ?? {};
      final String paramsEncoded = helper.encodeQueryParams(queryParams);
      return await _dashboardRepository.getDashboardLo(id, paramsEncoded);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }

  Future<ApiResponseModel<DashboardSloModel>> getDashboardSlo({required String id, Map<String, dynamic>? params}) async {
    try {
      final Map<String, dynamic> queryParams = params ?? {};
      final String paramsEncoded = helper.encodeQueryParams(queryParams);
      return await _dashboardRepository.getDashboardSlo(id, paramsEncoded);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }

  Future<ApiResponseModel<DashboardAmModel>> getDashboardAm({required String id, Map<String, dynamic>? params}) async {
    try {
      final Map<String, dynamic> queryParams = params ?? {};
      final String paramsEncoded = helper.encodeQueryParams(queryParams);
      return await _dashboardRepository.getDashboardAm(id, paramsEncoded);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }

  Future<ApiResponseModel<DashboardDireksiModel>> getDashboardDireksi([Map<String, dynamic>? params]) async {
    try {
      final String paramsEncoded = helper.encodeQueryParams(params ?? {});
      return await _dashboardRepository.getDashboardDireksi(paramsEncoded);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }
}
