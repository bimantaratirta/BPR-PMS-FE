import 'package:get/get.dart';

class NasabahNasabahCreateReportController extends GetxController {
  Rx<List<String>> evaluationList = Rx<List<String>>(['Good', 'Bad']);
  Rx<String?> pickEvaluation = Rx<String?>(null);
  void usePickEvaluation(String value) {
    pickEvaluation.value = value;
  }
}
