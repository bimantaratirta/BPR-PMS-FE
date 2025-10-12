import 'package:get/get.dart';

class NasabahNasabahCreateReportController extends GetxController {
  final id = Get.parameters['id'];

  @override
  void onInit() {
    if (id == null) {
      // Tangani kasus di mana ID tidak ada
      print("Error: ID nasabah tidak ditemukan!");
      // Mungkin arahkan kembali atau tampilkan pesan kesalahan
    } else {
      print("Loaded Nasabah with ID: $id");
      // Lakukan inisialisasi data berdasarkan ID
    }

    super.onInit();
  }

  Rx<List<String>> evaluationList = Rx<List<String>>(['Good', 'Bad']);
  Rx<String?> pickEvaluation = Rx<String?>(null);
  void usePickEvaluation(String value) {
    pickEvaluation.value = value;
  }
}
