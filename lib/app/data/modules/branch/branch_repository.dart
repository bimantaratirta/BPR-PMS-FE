import 'package:bpr_pms/app/common/constant/app_constants.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/main/api/api_params_model.dart';
import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/branch/models/branch_model.dart';
import 'package:bpr_pms/app/network/api_client.dart';

class BranchRepository {
  final Helper helper = Helper();

  Future<ApiResponseModel<List<BranchModel>>> getAllBranch() async {
    return await apiClient.get(
      ApiParams<List<BranchModel>>(
        path: AppConstants.branchEndpoint,
        fromJson: (json) => helper.listParser(json, BranchModel.fromJson),
      ),
    );
  }
}
