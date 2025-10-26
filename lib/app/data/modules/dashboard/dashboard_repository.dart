import 'package:bpr_pms/app/common/constant/app_constants.dart';
import 'package:bpr_pms/app/data/main/api/api_params_model.dart';
import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/dashboard/models/dashboard_am_model.dart';
import 'package:bpr_pms/app/data/modules/dashboard/models/dashboard_direksi_model.dart';
import 'package:bpr_pms/app/data/modules/dashboard/models/dashboard_lo_model.dart';
import 'package:bpr_pms/app/data/modules/dashboard/models/dashboard_slo_model.dart';
import 'package:bpr_pms/app/network/api_client.dart';

class DashboardRepository {
  Future<ApiResponseModel<DashboardLoModel>> getDashboardLo(String id, paramsEncoded) async {
    return await apiClient.get(
      ApiParams(
        path: "${AppConstants.dashboardLoEndpoint}/$id$paramsEncoded",
        fromJson: (json) => DashboardLoModel.fromJson(json),
      ),
    );
  }

  Future<ApiResponseModel<DashboardSloModel>> getDashboardSlo(String id, paramsEncoded) async {
    return await apiClient.get(
      ApiParams(
        path: "${AppConstants.dashboardSloEndpoint}/$id$paramsEncoded",
        fromJson: (json) => DashboardSloModel.fromJson(json),
      ),
    );
  }

  Future<ApiResponseModel<DashboardAmModel>> getDashboardAm(String id, String paramsEncoded) async {
    return await apiClient.get(
      ApiParams(
        path: "${AppConstants.dashboardAmEndpoint}/$id$paramsEncoded",
        fromJson: (json) => DashboardAmModel.fromJson(json),
      ),
    );
  }

  Future<ApiResponseModel<DashboardDireksiModel>> getDashboardDireksi(String paramsEncoded) async {
    return await apiClient.get(
      ApiParams(
        path: "${AppConstants.dashboardDireksiEndpoint}$paramsEncoded",
        fromJson: (json) => DashboardDireksiModel.fromJson(json),
      ),
    );
  }
}
