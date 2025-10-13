import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/report/model/report_model.dart';
import 'package:bpr_pms/app/data/modules/report/report_repository.dart';
import 'package:dio/dio.dart';

class ReportService {
  final ReportRepository _reportRepository = ReportRepository();
  final Helper helper = Helper();

  Future<ApiResponseModel<List<ReportModel>>> getAllReport([Map<String, dynamic>? params]) async {
    try {
      final String paramsEncoded = helper.encodeQueryParams(params ?? {});
      return await _reportRepository.getAllReport(paramsEncoded);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }

  Future<ApiResponseModel<ReportModel>> getReportById(String id) async {
    try {
      return await _reportRepository.getReportById(id);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }

  Future<ApiResponseModel<ReportModel>> createReport(FormData body) async {
    try {
      return await _reportRepository.createReport(body);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }
}
