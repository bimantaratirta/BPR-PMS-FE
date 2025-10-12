import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/customer/customer_repository.dart';
import 'package:bpr_pms/app/data/modules/customer/models/customer_model.dart';

class CustomerService {
  final CustomerRepository _customerRepository = CustomerRepository();
  final Helper helper = Helper();

  Future<ApiResponseModel<List<CustomerModel>>> getAllCustomer([Map<String, dynamic>? params]) async {
    try {
      final String paramsEncoded = helper.encodeQueryParams(params ?? {});
      return await _customerRepository.getAllCustomer(paramsEncoded);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }

  Future<ApiResponseModel<CustomerModel>> getCustomerById(String id) async {
    try {
      return await _customerRepository.getCustomerById(id);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }

  Future<ApiResponseModel<CustomerModel>> createCustomer(Map<String, dynamic> body) async {
    try {
      return await _customerRepository.createCustomer(body);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }

  Future<ApiResponseModel<CustomerModel>> updateCustomer(String id, Map<String, dynamic> body) async {
    try {
      return await _customerRepository.updateCustomer(id, body);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }
}
