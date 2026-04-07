import 'package:bpr_pms/app/common/constant/app_constants.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/main/api/api_params_model.dart';
import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/report/model/report_evaluation_review_model.dart';
import 'package:bpr_pms/app/data/modules/report/model/report_evaluation_slo_model.dart';
import 'package:bpr_pms/app/data/modules/report/model/report_model.dart';
import 'package:bpr_pms/app/data/modules/report/model/report_review_customer_model.dart';
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

  Future<ApiResponseModel<ReportReviewCustomerModel>> createReportReviewCustomer(Map<String, dynamic> body) async {
    return await apiClient.post(
      ApiParams(
        path: AppConstants.reportReviewCustomerEndpoint,
        body: body,
        fromJson: (json) => ReportReviewCustomerModel.fromJson(json),
      ),
    );
  }

  Future<ApiResponseModel<ReportEvaluationSloModel>> createReportEvaluationSlo(Map<String, dynamic> body) async {
    return await apiClient.post(
      ApiParams(
        path: AppConstants.reportEvaluationSloEndpoint,
        body: body,
        fromJson: (json) => ReportEvaluationSloModel.fromJson(json),
      ),
    );
  }

  Future<ApiResponseModel<ReportEvaluationReviewModel>> createReportEvaluationReview(Map<String, dynamic> body) async {
    return await apiClient.post(
      ApiParams(
        path: AppConstants.reportEvaluationReviewEndpoint,
        body: body,
        fromJson: (json) => ReportEvaluationReviewModel.fromJson(json),
      ),
    );
  }

  Future<ApiResponseModel> downloadReportXlsx(String paramsEncoded, String path) async {
    return await apiClient.getRaw(
      ApiParams(
        path: "${AppConstants.generateReportEndpoint}/$path$paramsEncoded",
        options: Options(responseType: ResponseType.bytes),
      ),
    );
  }
}
