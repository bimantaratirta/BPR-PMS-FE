import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/location/location_repository.dart';

class LocationService {
  final LocationRepository _locationRepository = LocationRepository();

  Future<ApiResponseModel<dynamic>> requestAllLocation() async {
    try {
      return await _locationRepository.requestAllLocation();
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }
}
