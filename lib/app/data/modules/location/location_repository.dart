import 'package:bpr_pms/app/common/constant/app_constants.dart';
import 'package:bpr_pms/app/data/main/api/api_params_model.dart';
import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/network/api_client.dart';

class LocationRepository {
  Future<ApiResponseModel<dynamic>> requestAllLocation() async {
    return await apiClient.post(
      ApiParams(
        path: "${AppConstants.currentLocationEndpoint}/request-all",
      ),
    );
  }
}
