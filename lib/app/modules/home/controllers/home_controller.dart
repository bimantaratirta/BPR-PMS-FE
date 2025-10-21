import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString selectedLoNasabahDisplayFilter = 'minggu'.obs;
  Rx<List<Map<String, String>>> itemsSelectLoNasabahDisplayFilter = Rx<List<Map<String, String>>>([
    {"value": "minggu", "label": "Minggu"},
    {"value": "bulan", "label": "Bulan"},
  ]);

  void changeSelectedLoNasabahDisplayFilter(String value) {
    selectedLoNasabahDisplayFilter.value = value;
  }
}
