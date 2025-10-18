import 'package:bpr_pms/app/data/modules/report/model/report_model.dart';
import 'package:bpr_pms/app/data/modules/report/report_service.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:bpr_pms/app/widgets/dialog/build_custom_dialog.dart';
import 'package:bpr_pms/app/widgets/dialog/content/confirmation_dialog_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  void handleEvaluationSloSubmit(BuildContext context) {
    if (selectedCharacterStatus.value == null ||
        selectedCapacityStatus.value == null ||
        selectedConditionStatus.value == null ||
        selectedCapitalStatus.value == null ||
        characterController.text.isEmpty ||
        capacityController.text.isEmpty ||
        conditionController.text.isEmpty ||
        capitalController.text.isEmpty) {
      message.value = "Silakan lengkapi semua data sebelum mengirim laporan.";
      CustomSnackbar(message: message.value, type: CustomSnackbarType.warning).show(context);
      return;
    }

    BuildCustomDialog.show(
      context: context,
      content: ConfirmationDialogContent(
        isLoading: isLoading,
        onTruePressed: () {
          createEvaluationSlo(context);
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
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

  Future createEvaluationSlo(BuildContext context) async {
    try {
      isLoading.value = true;
      message.value = '';

      final payload = {
        'report_id': id.value,
        'character': characterController.text,
        'status_character': selectedCharacterStatus.value == true ? 'GOOD' : 'BAD',
        'capacity': capacityController.text,
        'status_capacity': selectedCapacityStatus.value == true ? 'GOOD' : 'BAD',
        'condition': conditionController.text,
        'status_condition': selectedConditionStatus.value == true ? 'GOOD' : 'BAD',
        'capital': capitalController.text,
        'status_capital': selectedCapitalStatus.value == true ? 'GOOD' : 'BAD',
      };

      final response = await reportService.createReportEvaluationSlo(payload);

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
