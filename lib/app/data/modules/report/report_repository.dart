import 'package:bpr_pms/app/common/constant/app_constants.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/main/api/api_params_model.dart';
import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/report/model/report_model.dart';
import 'package:bpr_pms/app/network/api_client.dart';
import 'package:dio/dio.dart';

class ReportRepository {
  final Helper helper = Helper();

  Future<ApiResponseModel<List<ReportModel>>> getAllReport(String paramsEncoded) async {
    return await apiClient.get(
      ApiParams<List<ReportModel>>(
        path: "${AppConstants.reportEndpoint}$paramsEncoded",
        fromJson: (json) => helper.listParser(json, ReportModel.fromJson),
      ),
    );
  }

  Future<ApiResponseModel<ReportModel>> getReportById(String id) async {
    return await apiClient.get(
      ApiParams(path: "${AppConstants.reportEndpoint}/$id", fromJson: (json) => ReportModel.fromJson(json)),
    );
  }

  Future<ApiResponseModel<ReportModel>> createReport(FormData body) async {
    return await apiClient.post(
      ApiParams(
        path: AppConstants.reportEndpoint,
        formData: body,
        fromJson: (json) => ReportModel.fromJson(json),
        options: Options(contentType: 'multipart/form-data'),
      ),
    );
  }
}
