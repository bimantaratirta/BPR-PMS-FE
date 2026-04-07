import 'package:bpr_pms/app/data/main/api/api_response_model.dart';
import 'package:bpr_pms/app/data/modules/region/models/region_model.dart';
import 'package:bpr_pms/app/data/modules/region/region_repository.dart';

class RegionService {
  final RegionRepository _regionRepository = RegionRepository();

  Future<ApiResponseModel<List<RegionModel>>> getAllRegion() async {
    try {
      return await _regionRepository.getAllRegion();
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }

  Future<ApiResponseModel<RegionModel>> getRegionById(String id) async {
    try {
      return await _regionRepository.getRegionById(id);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }

  Future<ApiResponseModel<RegionModel>> createRegion(Map<String, dynamic> body) async {
    try {
      return await _regionRepository.createRegion(body);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }
}
