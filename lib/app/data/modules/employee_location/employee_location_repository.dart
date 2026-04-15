import 'package:bpr_pms/app/common/constant/app_constants.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/main/api/api_params_model.dart';
import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/employee_location/models/employee_location_model.dart';
import 'package:bpr_pms/app/network/api_client.dart';

class EmployeeLocationRepository {
  final Helper helper = Helper();

  Future<ApiResponseModel<List<EmployeeLocationModel>>> latestLocation(String paramsEncoded) async {
    return await apiClient.get(
      ApiParams<List<EmployeeLocationModel>>(
        path: "${AppConstants.currentLocationEndpoint}/latest$paramsEncoded",
        fromJson: (json) => helper.listParser(json, EmployeeLocationModel.fromJson),
      ),
    );
  }

  Future<ApiResponseModel<dynamic>> requestAllLocation() async {
    return await apiClient.post(ApiParams(path: "${AppConstants.currentLocationEndpoint}/request-all"));
  }
}
