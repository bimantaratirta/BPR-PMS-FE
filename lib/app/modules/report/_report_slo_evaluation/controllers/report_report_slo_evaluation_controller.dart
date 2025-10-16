import 'package:bpr_pms/app/data/modules/report/model/report_model.dart';
import 'package:bpr_pms/app/data/modules/report/report_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportReportSloEvaluationController extends GetxController {
  final ReportService reportService = ReportService();

  final TextEditingController characterController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController capitalController = TextEditingController();

  final RxString id = ''.obs;
  final isLoading = false.obs;
  final RxString message = ''.obs;
  final Rx<ReportModel?> reportData = Rx<ReportModel?>(null);

  final selectedCharacterStatus = Rx<bool?>(null);
  final selectedCapacityStatus = Rx<bool?>(null);
  final selectedConditionStatus = Rx<bool?>(null);
  final selectedCapitalStatus = Rx<bool?>(null);

  void selectCharacterStatus(bool option) {
    selectedCharacterStatus.value = option;
  }

  void selectCapacityStatus(bool option) {
    selectedCapacityStatus.value = option;
  }

  void selectConditionStatus(bool option) {
    selectedConditionStatus.value = option;
  }

  void selectCapitalStatus(bool option) {
    selectedCapitalStatus.value = option;
  }

  @override
  void onClose() {
    characterController.dispose();
    capacityController.dispose();
    conditionController.dispose();
    capitalController.dispose();
    super.onClose();
  }
}
