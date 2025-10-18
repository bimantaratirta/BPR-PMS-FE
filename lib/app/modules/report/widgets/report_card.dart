import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/modules/report/model/report_model.dart';
import 'package:bpr_pms/app/modules/report/controllers/report_controller.dart';
import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportCard extends StatelessWidget {
  final ReportModel reportData;

  const ReportCard({super.key, required this.reportData});

  @override
  Widget build(BuildContext context) {
    final ReportController reportController = Get.find<ReportController>();

    if (reportController.isReportCanBeReviewed(reportData) == false) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 4))],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reportData.customerSnapshot?.name ?? "-",
                style: Get.textTheme.titleMedium!.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(color: MainColor.blueLight, borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("No Handphone", style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500)),
                          Text(
                            reportData.customerSnapshot?.phoneNumber ?? "-",
                            style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: SecondaryColor.neutral300, height: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("RT/RW", style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500)),
                          Text(
                            reportData.customerSnapshot?.rtRw ?? "-",
                            style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.reportDetail(reportData.id ?? ""));
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SizedBox(
                      child: Text(
                        "Detail",
                        style: Get.textTheme.labelMedium!.copyWith(color: MainColor.blueNormal, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: MainColor.blueNormal, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reportData.customerSnapshot?.name ?? "-",
              style: Get.textTheme.titleMedium!.copyWith(color: SecondaryColor.white, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(color: SecondaryColor.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tanggal", style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500)),
                        Text(
                          Helper().formatDateTimeToID(reportData.createdAt),
                          style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: SecondaryColor.neutral200, height: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Proses", style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500)),
                        Text(
                          reportController.getReportProcessDisplayName(reportData.process),
                          style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: SecondaryColor.neutral200, height: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Status", style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500)),
                        Text(
                          reportData.status == "GOOD"
                              ? "Good"
                              : reportData.status == "BAD"
                              ? "Bad"
                              : "Unknown",
                          style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MainColor.blueNormalActive,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                    ),
                    onPressed: () {
                      if (reportData.process == "REVIEW_SLO" || reportData.process == "EVALUATION_SLO") {
                        Get.toNamed(Routes.reportSloReview(reportData.id ?? ""));
                      } else {
                        CustomSnackbar(message: "Data proses tidak valid.", type: CustomSnackbarType.warning).show(context);
                      }
                    },
                    child: Text(
                      "Review",
                      style: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
