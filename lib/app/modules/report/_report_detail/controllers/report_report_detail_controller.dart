import 'package:bpr_pms/app/data/modules/report/model/report_model.dart';
import 'package:bpr_pms/app/data/modules/report/report_service.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportReportDetailController extends GetxController {
  final ReportService reportService = ReportService();

  final TextEditingController characterController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController capitalController = TextEditingController();

  final selectedCharacterStatus = Rx<bool?>(null);
  final selectedCapacityStatus = Rx<bool?>(null);
  final selectedConditionStatus = Rx<bool?>(null);
  final selectedCapitalStatus = Rx<bool?>(null);

  final RxString id = ''.obs;
  final isLoading = false.obs;
  final RxString message = ''.obs;
  final Rx<ReportModel?> reportData = Rx<ReportModel?>(null);

  void updateEvaluationFields(ReportModel report) {
    characterController.text = report.evaluation?.character ?? '';
    capacityController.text = report.evaluation?.capacity ?? '';
    conditionController.text = report.evaluation?.condition ?? '';
    capitalController.text = report.evaluation?.capital ?? '';

    selectedCharacterStatus.value = report.evaluation?.statusCharacter == "GOOD"
        ? true
        : report.evaluation?.statusCharacter == "BAD"
        ? false
        : null;
    selectedCapacityStatus.value = report.evaluation?.statusCapacity == "GOOD"
        ? true
        : report.evaluation?.statusCapacity == "BAD"
        ? false
        : null;
    selectedConditionStatus.value = report.evaluation?.statusCondition == "GOOD"
        ? true
        : report.evaluation?.statusCondition == "BAD"
        ? false
        : null;
    selectedCapitalStatus.value = report.evaluation?.statusCapital == "GOOD"
        ? true
        : report.evaluation?.statusCapital == "BAD"
        ? false
        : null;
  }

  @override
  void onClose() {
    characterController.dispose();
    capacityController.dispose();
    conditionController.dispose();
    capitalController.dispose();
    super.onClose();
  }

  Future<ReportModel?> getReportById(BuildContext context, String id) async {
    try {
      isLoading.value = true;
      message.value = '';

      final response = await reportService.getReportById(id);

      isLoading.value = false;

      if (response.code == 200) {
        message.value = "Data laporan berhasil diambil!";
        updateEvaluationFields(response.data!);
        return response.data ?? null;
      } else {
        String errorMsg = response.message ?? "Data laporan gagal diambil. Silakan coba lagi.";
        message.value = errorMsg;
        CustomSnackbar(message: errorMsg, type: CustomSnackbarType.warning).show(context);
        return null;
      }
    } catch (e) {
      isLoading.value = false;
      message.value = e.toString();
      CustomSnackbar(message: message.value, type: CustomSnackbarType.error).show(context);
      return null;
    }
  }
}
