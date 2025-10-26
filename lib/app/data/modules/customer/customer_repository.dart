import 'package:bpr_pms/app/common/constant/app_constants.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/main/api/api_params_model.dart';
import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/customer/models/customer_model.dart';
import 'package:bpr_pms/app/network/api_client.dart';

class CustomerRepository {
  final Helper helper = Helper();

  Future<ApiResponseModel<List<CustomerModel>>> getAllCustomer(String paramsEncoded) async {
    return await apiClient.get(
      ApiParams<List<CustomerModel>>(
        path: "${AppConstants.customerEndpoint}$paramsEncoded",
        fromJson: (json) => helper.listParser(json, CustomerModel.fromJson),
      ),
    );
  }

  Future<ApiResponseModel<List<CustomerModel>>> getAllCustomerByLo(String id, String paramsEncoded) async {
    return await apiClient.get(
      ApiParams<List<CustomerModel>>(
        path: "${AppConstants.customerByLoEndpoint}/$id$paramsEncoded",
        fromJson: (json) => helper.listParser(json, CustomerModel.fromJson),
      ),
    );
  }

  Future<ApiResponseModel<CustomerModel>> getCustomerById(String id) async {
    return await apiClient.get(
      ApiParams(path: "${AppConstants.customerEndpoint}/$id", fromJson: (json) => CustomerModel.fromJson(json)),
    );
  }

  Future<ApiResponseModel<CustomerModel>> createCustomer(Map<String, dynamic> body) async {
    return await apiClient.post(
      ApiParams(path: AppConstants.customerEndpoint, body: body, fromJson: (json) => CustomerModel.fromJson(json)),
    );
  }

  Future<ApiResponseModel<CustomerModel>> updateCustomer(String id, Map<String, dynamic> body) async {
    return await apiClient.put(
      ApiParams(path: "${AppConstants.customerEndpoint}/$id", body: body, fromJson: (json) => CustomerModel.fromJson(json)),
    );
  }
}
