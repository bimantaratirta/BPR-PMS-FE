import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/modules/report/_report_slo_review/controllers/report_report_slo_review_controller.dart';
import 'package:bpr_pms/app/modules/report/widgets/report_select_status.dart';
import 'package:bpr_pms/app/widgets/build_custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/report_report_slo_evaluation_controller.dart';

class ReportReportSloEvaluationView extends GetView<ReportReportSloEvaluationController> {
  const ReportReportSloEvaluationView({super.key});
  @override
  Widget build(BuildContext context) {
    final ReportReportSloReviewController reportSloReviewController = Get.find<ReportReportSloReviewController>();

    final String? itemId = Get.parameters['id'];

    if (itemId != null && controller.id.value != itemId) {
      controller.id.value = itemId;
      controller.reportData.value = reportSloReviewController.reportData.value;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Penilaian',
          style: Get.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: SvgPicture.asset(height: 16.h, IconAssets.chevronLeft, color: MainColor.blueNormal),
            onPressed: () {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
          ),
        ),
        titleSpacing: 4,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 25),
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: Get.size.height * 0.02),
                Text("Karakter", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 12),
                BuildCustomTextFormField(
                  hintText: "Tambahkan penilaian...",
                  controller: controller.characterController,
                  maxLines: 6,
                  isReadOnly: false,
                  isEnable: true,
                  withInputFormatter: false,
                  contentPadding: EdgeInsets.all(16),
                ),
                ReportSelectStatus(
                  trueLabel: "Good",
                  falseLabel: "Bad",
                  onSelect: (value) => controller.selectCharacterStatus(value),
                  selectedStatus: controller.selectedCharacterStatus,
                  falseColor: SecondaryColor.danger600,
                  trueColor: SecondaryColor.success600,
                ),
                Text("Kapasitas", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 12),
                BuildCustomTextFormField(
                  hintText: "Tambahkan penilaian...",
                  controller: controller.capacityController,
                  maxLines: 6,
                  isReadOnly: false,
                  isEnable: true,
                  withInputFormatter: false,
                  contentPadding: EdgeInsets.all(16),
                ),
                ReportSelectStatus(
                  trueLabel: "Good",
                  falseLabel: "Bad",
                  onSelect: (value) => controller.selectCapacityStatus(value),
                  selectedStatus: controller.selectedCapacityStatus,
                  falseColor: SecondaryColor.danger600,
                  trueColor: SecondaryColor.success600,
                ),
                Text("Kondisi", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 12),
                BuildCustomTextFormField(
                  hintText: "Tambahkan penilaian...",
                  controller: controller.conditionController,
                  maxLines: 6,
                  isReadOnly: false,
                  isEnable: true,
                  withInputFormatter: false,
                  contentPadding: EdgeInsets.all(16),
                ),
                ReportSelectStatus(
                  trueLabel: "Good",
                  falseLabel: "Bad",
                  onSelect: (value) => controller.selectConditionStatus(value),
                  selectedStatus: controller.selectedConditionStatus,
                  falseColor: SecondaryColor.danger600,
                  trueColor: SecondaryColor.success600,
                ),
                Text("Kapital", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 12),
                BuildCustomTextFormField(
                  hintText: "Tambahkan penilaian...",
                  controller: controller.capitalController,
                  maxLines: 6,
                  isReadOnly: false,
                  isEnable: true,
                  withInputFormatter: false,
                  contentPadding: EdgeInsets.all(16),
                ),
                ReportSelectStatus(
                  trueLabel: "Good",
                  falseLabel: "Bad",
                  onSelect: (value) => controller.selectCapitalStatus(value),
                  selectedStatus: controller.selectedCapitalStatus,
                  falseColor: SecondaryColor.danger600,
                  trueColor: SecondaryColor.success600,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: Get.size.width * 0.3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MainColor.blueNormal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                      ),
                      onPressed: () {
                        controller.handleEvaluationSloSubmit(context);
                      },
                      child: Text(
                        "Submit",
                        style: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
