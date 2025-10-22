import 'package:bpr_pms/app/data/modules/report/model/report_model.dart';
import 'package:bpr_pms/app/data/modules/report/report_service.dart';
import 'package:bpr_pms/app/modules/report/controllers/report_controller.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:bpr_pms/app/widgets/dialog/build_custom_dialog.dart';
import 'package:bpr_pms/app/widgets/dialog/content/confirmation_dialog_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReportReportAmEvaluationReviewController extends GetxController {
  final ReportService reportService = ReportService();
  final ReportController reportController = Get.find<ReportController>();

  final TextEditingController characterController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController capitalController = TextEditingController();

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

  final RxString id = ''.obs;
  final isLoading = false.obs;
  final RxString message = ''.obs;
  final Rx<ReportModel?> reportData = Rx<ReportModel?>(null);

  void updateEvaluationFields(ReportModel report) {
    characterController.text = report.evaluation?.character ?? '';
    capacityController.text = report.evaluation?.capacity ?? '';
    conditionController.text = report.evaluation?.condition ?? '';
    capitalController.text = report.evaluation?.capital ?? '';
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

  void handleEvaluationReviewSubmit(BuildContext context) {
    if (selectedCharacterStatus.value == null ||
        selectedCapacityStatus.value == null ||
        selectedConditionStatus.value == null ||
        selectedCapitalStatus.value == null) {
      message.value = "Silakan lengkapi semua data sebelum mengirim laporan.";
      CustomSnackbar(message: message.value, type: CustomSnackbarType.warning).show(context);
      return;
    }

    BuildCustomDialog.show(
      context: context,
      content: ConfirmationDialogContent(
        isLoading: isLoading,
        onTruePressed: () {
          createEvaluationReview(context);
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
          reportController.refreshData(context);
        },
        onFalsePressed: () {
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
        },
        message: "Apakah Data yang di Masukkan Sudah Sesuai?",
      ),
      height: null,
      width: Get.size.width * 0.85,
      padding: EdgeInsets.symmetric(horizontal: 42.w, vertical: 20.h),
      borderRadius: 15,
    );
  }

  Future createEvaluationReview(BuildContext context) async {
    try {
      isLoading.value = true;
      message.value = '';

      final payload = {
        'evaluation_id': reportData.value?.evaluation?.id,
        'review_character': selectedCharacterStatus.value,
        'review_capacity': selectedCapacityStatus.value,
        'review_condition': selectedConditionStatus.value,
        'review_capital': selectedCapitalStatus.value,
      };

      final response = await reportService.createReportEvaluationReview(payload);

      isLoading.value = false;

      if (response.code == 200 || response.code == 201) {
        message.value = "Laporan berhasil dibuat!";
        CustomSnackbar(message: message.value, type: CustomSnackbarType.success).show(context);
      } else {
        String errorMsg = response.message ?? "Laporan gagal dibuat. Silakan coba lagi.";
        message.value = errorMsg;
        CustomSnackbar(message: errorMsg, type: CustomSnackbarType.warning).show(context);
      }
    } catch (e) {
      isLoading.value = false;
      message.value = e.toString();
      CustomSnackbar(message: message.value, type: CustomSnackbarType.error).show(context);
    }
  }
}
