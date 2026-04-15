import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/employee_location/employee_location_repository.dart';
import 'package:bpr_pms/app/data/modules/employee_location/models/employee_location_model.dart';

class EmployeeLocationService {
  final EmployeeLocationRepository _employeeLocationRepository = EmployeeLocationRepository();
  final Helper helper = Helper();

  Future<ApiResponseModel<List<EmployeeLocationModel>>> latestLocation([Map<String, dynamic>? params]) async {
    try {
      final String paramsEncoded = helper.encodeQueryParams(params ?? {});
      return await _employeeLocationRepository.latestLocation(paramsEncoded);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }

  Future<ApiResponseModel<dynamic>> requestAllLocation() async {
    try {
      return await _employeeLocationRepository.requestAllLocation();
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }
}
