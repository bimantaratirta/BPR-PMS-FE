import 'package:bpr_pms/app/common/constant/app_constants.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/main/api/api_params_model.dart';
import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/customer/models/customer_model.dart';
import 'package:bpr_pms/app/network/api_client.dart';

class CustomerRepository {
  final Helper helper = Helper();

  Future<ApiResponseModel<List<CustomerModel>>> getAllCustomer() async {
    return await apiClient.get(
      ApiParams<List<CustomerModel>>(
        path: AppConstants.customerEndpoint,
        fromJson: (json) => helper.listParser(json, CustomerModel.fromJson),
      ),
    );
  }
}
