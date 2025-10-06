import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/customer/customer_repository.dart';
import 'package:bpr_pms/app/data/modules/customer/models/customer_model.dart';

class CustomerService {
  final CustomerRepository _customerRepository = CustomerRepository();

  Future<ApiResponseModel<List<CustomerModel>>> getAllCustomer() async {
    try {
      return await _customerRepository.getAllCustomer();
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }
}
