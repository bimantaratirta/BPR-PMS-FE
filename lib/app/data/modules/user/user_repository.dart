import 'package:bpr_pms/app/common/constant/app_constants.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/main/api/api_params_model.dart';
import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/user/models/user_model.dart';
import 'package:bpr_pms/app/network/api_client.dart';

class UserRepository {
  final Helper helper = Helper();

  Future<ApiResponseModel<List<UserModel>>> getAllUsers(String paramsEncoded) async {
    return await apiClient.get(
      ApiParams<List<UserModel>>(
        path: "${AppConstants.userEndpoint}$paramsEncoded",
        fromJson: (json) => helper.listParser(json, UserModel.fromJson),
      ),
    );
  }

  Future<ApiResponseModel<List<UserModel>>> getAllLoBySlo(String id, String paramsEncoded) async {
    return await apiClient.get(
      ApiParams<List<UserModel>>(
        path: "${AppConstants.userLoBySloEndpoint}/$id$paramsEncoded",
        fromJson: (json) => helper.listParser(json, UserModel.fromJson),
      ),
    );
  }

  Future<ApiResponseModel<List<UserModel>>> getAllSloByAm(String id, String paramsEncoded) async {
    return await apiClient.get(
      ApiParams<List<UserModel>>(
        path: "${AppConstants.userSloByAmEndpoint}/$id$paramsEncoded",
        fromJson: (json) => helper.listParser(json, UserModel.fromJson),
      ),
    );
  }

  Future<ApiResponseModel<UserModel>> getUserById(String id) async {
    return await apiClient.get(
      ApiParams(path: "${AppConstants.userEndpoint}/$id", fromJson: (json) => UserModel.fromJson(json)),
    );
  }

  Future<ApiResponseModel<UserModel>> createUser(Map<String, dynamic> body) async {
    return await apiClient.post(
      ApiParams<UserModel>(
        path: AppConstants.userEndpoint,
        body: body,
        fromJson: (json) => UserModel.fromJson(json),
      ),
    );
  }

  Future<ApiResponseModel<UserModel>> updateUser(String id, Map<String, dynamic> body) async {
    return await apiClient.put(
      ApiParams<UserModel>(
        path: "${AppConstants.userEndpoint}/$id",
        body: body,
        fromJson: (json) => UserModel.fromJson(json),
      ),
    );
  }

  Future<ApiResponseModel> deleteUser(String id) async {
    return await apiClient.delete(
      ApiParams(path: "${AppConstants.userEndpoint}/$id", fromJson: (json) => null),
    );
  }

  Future<ApiResponseModel<UserModel>> restoreUser(String id) async {
    return await apiClient.patch(
      ApiParams<UserModel>(
        path: "${AppConstants.userEndpoint}/$id/restore",
        fromJson: (json) => UserModel.fromJson(json),
      ),
    );
  }

  Future<ApiResponseModel> resetPassword(String id, Map<String, dynamic> body) async {
    return await apiClient.patch(
      ApiParams(
        path: "${AppConstants.userEndpoint}/$id/password",
        body: body,
        fromJson: (json) => null,
      ),
    );
  }
}
