import 'package:bpr_pms/app/common/constant/app_constants.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/main/api/api_params_model.dart';
import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/region/models/region_model.dart';
import 'package:bpr_pms/app/network/api_client.dart';

class RegionRepository {
  final Helper helper = Helper();

  Future<ApiResponseModel<List<RegionModel>>> getAllRegion() async {
    return await apiClient.get(
      ApiParams<List<RegionModel>>(
        path: AppConstants.regionEndpoint,
        fromJson: (json) => helper.listParser(json, RegionModel.fromJson),
      ),
    );
  }

  Future<ApiResponseModel<RegionModel>> getRegionById(String id) async {
    return await apiClient.get(
      ApiParams(path: "${AppConstants.regionEndpoint}/$id", fromJson: (json) => RegionModel.fromJson(json)),
    );
  }
}
