import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString selectedLoNasabahDisplayFilter = 'minggu'.obs;
  Rx<List<Map<String, String>>> itemsSelectLoNasabahDisplayFilter = Rx<List<Map<String, String>>>([
    {"value": "minggu", "label": "Minggu"},
    {"value": "bulan", "label": "Bulan"},
  ]);

  final List<Map<String, dynamic>> loNasabahChartData = [
    {'label': 'LO 1', 'value': 12},
    {'label': 'LO 2', 'value': 22},
    {'label': 'LO 3', 'value': 1},
    {'label': 'LO 4', 'value': 4},
  ];

  final List<Map<String, dynamic>> sloNasabahChartData = [
    {'label': 'LO 1', 'value': 12},
    {'label': 'LO 2', 'value': 22},
    {'label': 'LO 3', 'value': 1},
    {'label': 'LO 4', 'value': 4},
  ];

  final List<Map<String, dynamic>> regionNasabahChartData = [
    {'label': 'Utara', 'value': 12},
    {'label': 'Selatan', 'value': 22},
    {'label': 'Timur', 'value': 1},
    {'label': 'Barat', 'value': 4},
  ];

  void changeSelectedLoNasabahDisplayFilter(String value) {
    selectedLoNasabahDisplayFilter.value = value;
  }
}
