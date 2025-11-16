import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/branch/branch_repository.dart';
import 'package:bpr_pms/app/data/modules/branch/models/branch_model.dart';

class BranchService {
  final BranchRepository _branchRepository = BranchRepository();

  Future<ApiResponseModel<List<BranchModel>>> getAllBranch() async {
    try {
      return await _branchRepository.getAllBranch();
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }

  Future<ApiResponseModel<BranchModel>> createBranch(Map<String, dynamic> body) async {
    try {
      return await _branchRepository.createBranch(body);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }
}
