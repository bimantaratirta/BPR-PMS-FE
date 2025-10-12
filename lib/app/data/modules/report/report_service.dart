import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/report/model/report_model.dart';
import 'package:bpr_pms/app/data/modules/report/report_repository.dart';
import 'package:dio/dio.dart';

class ReportService {
  final ReportRepository _reportRepository = ReportRepository();
  final Helper helper = Helper();

  Future<ApiResponseModel<ReportModel>> createReport(FormData body) async {
    try {
      return await _reportRepository.createReport(body);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }
}
