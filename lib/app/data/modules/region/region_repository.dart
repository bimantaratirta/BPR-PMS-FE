import 'package:bpr_pms/app/common/constant/app_constants.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/main/api/api_params_model.dart';
import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/region/models/region_model.dart';
import 'package:bpr_pms/app/network/api_client.dart';

class RegionRepository {
  final Helper helper = Helper();

  Future<ApiResponseModel<List<RegionModel>>> getAllRegion() async {
    final response = await apiClient.get(
      ApiParams<List<RegionModel>>(
        path: AppConstants.regionEndpoint,
        fromJson: (json) => helper.listParser(json, RegionModel.fromJson),
      ),
    );

    print("Region Repository Response: $response");
    print(response.data);

    return response;
  }
}
