import 'package:bpr_pms/app/data/modules/report/model/report_model.dart';
import 'package:bpr_pms/app/data/modules/report/report_service.dart';
import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  final ReportService reportService = ReportService();

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  final Rx<List<ReportModel>> reportsData = Rx<List<ReportModel>>([]);
  final isLoading = false.obs;
  final RxString message = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMoreData = true.obs;
  final int limit = 5;
  final isPagingLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllReport(Get.context!, isInitialLoad: true);

    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });

    debounce(searchQuery, (_) async {
      currentPage.value = 1;
      hasMoreData.value = true;
      reportsData.value = [];
      await getAllReport(Get.context!, isInitialLoad: true);
    }, time: const Duration(milliseconds: 1000));
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  String getReportProcessDisplayName(String? reportProcess) {
    switch (reportProcess) {
      case "DECLINE_LO":
        return "Ditolak LO";
      case "REVIEW_SLO":
        return "Persetujuan SLO";
      case "DECLINE_REVIEW_SLO":
        return "Ditolak Persetujuan SLO";
      case "EVALUATION_SLO":
        return "Evaluasi SLO";
      case "DECLINE_EVALUATION_SLO":
        return "Ditolak Evaluasi SLO";
      case "REVIEW_AM":
        return "Persetujuan AM";
      case "APPROVE_AM":
        return "Disetujui AM";
      case "DECLINE_AM":
        return "Ditolak AM";
      default:
        return "Unknown";
    }
  }

  bool isReportCanBeReviewed(ReportModel report) {
    final UserRole? role = authController.pickRole.value;
    switch (role) {
      case UserRole.am:
        if (report.process == "REVIEW_AM") {
          return true;
        }
        return false;
      case UserRole.slo:
        if (report.process == "REVIEW_SLO" || report.process == "EVALUATION_SLO") {
          return true;
        }
        return false;
      case UserRole.lo:
        return false;
      default:
        return false;
    }
  }

  Future<void> refreshData(BuildContext context) async {
    currentPage.value = 1;
    hasMoreData.value = true;
    reportsData.value = [];
    await getAllReport(context, isInitialLoad: true);
  }

  Future<void> getAllReport(BuildContext context, {bool isInitialLoad = false}) async {
    if ((isInitialLoad && isLoading.value) ||
        (!isInitialLoad && (isLoading.value || isPagingLoading.value || !hasMoreData.value))) {
      return;
    }

    try {
      if (isInitialLoad) {
        isLoading.value = true;
        message.value = '';
      } else {
        isPagingLoading.value = true;
      }

      final params = {
        'search': searchController.text.trim(),
        'pagination': {'page': currentPage.value, 'limit': limit},
        'include_relation': ["lo", 'slo', "am", "report_photo", "review_customer", "evaluation"],
      };

      final response = await reportService.getAllReport(params);

      if (isInitialLoad) {
        isLoading.value = false;
      } else {
        isPagingLoading.value = false;
      }

      if (response.code == 200) {
        final newReports = response.data ?? [];

        if (currentPage.value == 1) {
          reportsData.value = newReports;
        } else {
          reportsData.value.addAll(newReports);
          reportsData.refresh();
        }

        hasMoreData.value = newReports.length == limit;

        if (hasMoreData.value) {
          currentPage.value++;
        }

        message.value = isInitialLoad
            ? "Data laporan berhasil diambil!"
            : newReports.isEmpty
            ? "Semua data laporan sudah dimuat."
            : "Data laporan halaman ${currentPage.value - 1} berhasil dimuat!";
      } else {
        String errorMsg = response.message ?? "Data laporan gagal diambil. Silakan coba lagi.";
        message.value = errorMsg;
        hasMoreData.value = false;
        CustomSnackbar(message: errorMsg, type: CustomSnackbarType.warning).show(context);
      }
    } catch (e) {
      isLoading.value = false;
      isPagingLoading.value = false;
      hasMoreData.value = false;
      message.value = e.toString();
      CustomSnackbar(message: message.value, type: CustomSnackbarType.error).show(context);
    }
  }
}
