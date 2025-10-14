import 'package:bpr_pms/app/data/modules/report/model/report_model.dart';
import 'package:bpr_pms/app/data/modules/report/report_service.dart';
import 'package:bpr_pms/app/modules/report/controllers/report_controller.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportReportSloReviewController extends GetxController {
  final ReportService reportService = ReportService();
  final ReportController reportController = Get.find<ReportController>();

  final RxString id = ''.obs;
  final isLoading = false.obs;
  final RxString message = ''.obs;
  final Rx<ReportModel?> reportData = Rx<ReportModel?>(null);

  final selectedIdentityStatus = Rx<bool?>(null);
  final selectedDomicileStatus = Rx<bool?>(null);
  final selectedWorkStatus = Rx<bool?>(null);

  void selectIdentityStatus(bool option) {
    selectedIdentityStatus.value = option;
  }

  void selectDomicileStatus(bool option) {
    selectedDomicileStatus.value = option;
  }

  void selectWorkStatus(bool option) {
    selectedWorkStatus.value = option;
  }

  Future<ReportModel?> getReportById(BuildContext context, String id) async {
    try {
      isLoading.value = true;
      message.value = '';

      final response = await reportService.getReportById(id);

      isLoading.value = false;

      if (response.code == 200) {
        message.value = "Data laporan berhasil diambil!";
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

  Future createCustomerReport(BuildContext context) async {
    try {
      if (selectedIdentityStatus.value == null || selectedDomicileStatus.value == null || selectedWorkStatus.value == null) {
        message.value = "Silakan lengkapi semua pilihan review sebelum mengirim laporan.";
        CustomSnackbar(message: message.value, type: CustomSnackbarType.warning).show(context);
        return;
      }

      isLoading.value = true;
      message.value = '';

      final payload = {
        'report_id': id.value,
        'review_identity': selectedIdentityStatus.value ?? false,
        'review_domicile': selectedDomicileStatus.value ?? false,
        'review_work': selectedWorkStatus.value ?? false,
      };

      final response = await reportService.createReportReviewCustomer(payload);

      isLoading.value = false;

      if (response.code == 200 || response.code == 201) {
        message.value = "Laporan berhasil dibuat!";
        CustomSnackbar(message: message.value, type: CustomSnackbarType.success).show(context);
        FocusScope.of(context).unfocus();
        Navigator.pop(context);
        reportController.refreshData(Get.context!);
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
