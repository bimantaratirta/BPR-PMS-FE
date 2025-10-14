import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/app_constants.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/modules/report/controllers/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/report_report_slo_review_controller.dart';

class ReportReportSloReviewView extends GetView<ReportReportSloReviewController> {
  const ReportReportSloReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportController reportController = Get.find<ReportController>();

    final String? itemId = Get.parameters['id'];

    if (itemId != null && controller.id.value != itemId) {
      controller.id.value = itemId;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        controller.reportData.value = await controller.getReportById(Get.context!, itemId);
      });
    }

    return Obx(() {
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
                reportController.refreshData(Get.context!);
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
                  Text("Data Identitas", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.size.width * 0.30,
                          child: Text(
                            "Nama",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: Get.size.width * 0.02),
                        Expanded(
                          child: Text(
                            controller.reportData.value?.customerSnapshot?.name ?? "-",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.size.width * 0.30,
                          child: Text(
                            "Nomor KTP",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: Get.size.width * 0.02),
                        Expanded(
                          child: Text(
                            controller.reportData.value?.customerSnapshot?.ktpNumber ?? "-",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.size.width * 0.30,
                          child: Text(
                            "Tanggal Lahir",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: Get.size.width * 0.02),
                        Expanded(
                          child: Text(
                            Helper().formatDateTimeToID(controller.reportData.value?.customerSnapshot?.dateOfBirth),
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.size.width * 0.30,
                          child: Text(
                            "No Handphone",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: Get.size.width * 0.02),
                        Expanded(
                          child: Text(
                            controller.reportData.value?.customerSnapshot?.phoneNumber ?? "-",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () => controller.selectIdentityStatus(false),
                                  child: Obx(() {
                                    final isActive = controller.selectedIdentityStatus.value == false;

                                    return Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: isActive ? MainColor.blueNormal : Colors.transparent,
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color: SecondaryColor.neutral300, width: 2),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          "Tidak Sesuai",
                                          style: Get.textTheme.labelMedium!.copyWith(
                                            color: isActive ? SecondaryColor.neutral600 : SecondaryColor.neutral500,
                                            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                                SizedBox(width: 28.w),
                                GestureDetector(
                                  onTap: () => controller.selectIdentityStatus(true),
                                  child: Obx(() {
                                    final isActive = controller.selectedIdentityStatus.value == true;

                                    return Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: isActive ? MainColor.blueNormal : Colors.transparent,
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color: SecondaryColor.neutral300, width: 2),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          "Sesuai",
                                          style: Get.textTheme.labelMedium!.copyWith(
                                            color: isActive ? SecondaryColor.neutral600 : SecondaryColor.neutral500,
                                            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: Get.textTheme.labelMedium!.copyWith(
                                color: SecondaryColor.neutral500,
                                fontWeight: FontWeight.w600,
                              ),
                              children: <TextSpan>[
                                TextSpan(text: 'Ket: '),
                                TextSpan(
                                  text: 'None',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Text("Alamat Domisili", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.size.width * 0.30,
                          child: Text(
                            "Desa",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: Get.size.width * 0.02),
                        Expanded(
                          child: Text(
                            controller.reportData.value?.customerSnapshot?.village ?? "-",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.size.width * 0.30,
                          child: Text(
                            "RT/RW",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: Get.size.width * 0.02),
                        Expanded(
                          child: Text(
                            controller.reportData.value?.customerSnapshot?.rtRw ?? "-",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.size.width * 0.30,
                          child: Text(
                            "Alamat",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: Get.size.width * 0.02),
                        Expanded(
                          child: Text(
                            controller.reportData.value?.customerSnapshot?.address ?? "-",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () => controller.selectDomicileStatus(false),
                                  child: Obx(() {
                                    final isActive = controller.selectedDomicileStatus.value == false;

                                    return Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: isActive ? MainColor.blueNormal : Colors.transparent,
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color: SecondaryColor.neutral300, width: 2),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          "Tidak Sesuai",
                                          style: Get.textTheme.labelMedium!.copyWith(
                                            color: isActive ? SecondaryColor.neutral600 : SecondaryColor.neutral500,
                                            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                                SizedBox(width: 28.w),
                                GestureDetector(
                                  onTap: () => controller.selectDomicileStatus(true),
                                  child: Obx(() {
                                    final isActive = controller.selectedDomicileStatus.value == true;

                                    return Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: isActive ? MainColor.blueNormal : Colors.transparent,
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color: SecondaryColor.neutral300, width: 2),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          "Sesuai",
                                          style: Get.textTheme.labelMedium!.copyWith(
                                            color: isActive ? SecondaryColor.neutral600 : SecondaryColor.neutral500,
                                            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: Get.textTheme.labelMedium!.copyWith(
                                color: SecondaryColor.neutral500,
                                fontWeight: FontWeight.w600,
                              ),
                              children: <TextSpan>[
                                TextSpan(text: 'Ket: '),
                                TextSpan(
                                  text: 'None',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Text("Jenis Usaha/Pekerjaan", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.size.width * 0.30,
                          child: Text(
                            "Tipe",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: Get.size.width * 0.02),
                        Expanded(
                          child: Text(
                            controller.reportData.value?.customerSnapshot?.workType ?? "-",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  controller.reportData.value?.customerSnapshot?.workType == "Pekerja Lepas"
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.size.width * 0.30,
                                    child: Text(
                                      "Pekerjaan",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.size.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      controller.reportData.value?.nonEmployeeSnapshot?.occupation ?? "-",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.size.width * 0.30,
                                    child: Text(
                                      "Pendapatan",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.size.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      "${Helper().formatToRupiah(controller.reportData.value?.nonEmployeeSnapshot?.salary)} /${controller.reportData.value?.nonEmployeeSnapshot?.salaryFrequency ?? "-"}",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : controller.reportData.value?.customerSnapshot?.workType == "Pengusaha"
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.size.width * 0.30,
                                    child: Text(
                                      "Jenis Usaha",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.size.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      controller.reportData.value?.businessSnapshot?.businessType ?? "-",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.size.width * 0.30,
                                    child: Text(
                                      "Total Karyawan",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.size.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      (controller.reportData.value?.businessSnapshot?.employeeCount ?? "-").toString(),
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.size.width * 0.30,
                                    child: Text(
                                      "Pendapatan",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.size.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      "${Helper().formatToRupiah(controller.reportData.value?.businessSnapshot?.revenue)} /bulan",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : controller.reportData.value?.customerSnapshot?.workType == "Karyawan Tetap"
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.size.width * 0.30,
                                    child: Text(
                                      "Perusahaan",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.size.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      controller.reportData.value?.employeeSnapshot?.companyName ?? "-",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.size.width * 0.30,
                                    child: Text(
                                      "Alamat",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.size.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      controller.reportData.value?.employeeSnapshot?.companyAddress ?? "-",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.size.width * 0.30,
                                    child: Text(
                                      "No Handphone",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.size.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      controller.reportData.value?.employeeSnapshot?.companyPhone ?? "-",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.size.width * 0.30,
                                    child: Text(
                                      "Pekerjaan",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.size.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      controller.reportData.value?.employeeSnapshot?.occupation ?? "-",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.size.width * 0.30,
                                    child: Text(
                                      "Posisi",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.size.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      controller.reportData.value?.employeeSnapshot?.position ?? "-",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.size.width * 0.30,
                                    child: Text(
                                      "Pendapatan",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.size.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      "${Helper().formatToRupiah(controller.reportData.value?.employeeSnapshot?.salary)} /bulan",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () => controller.selectedWorkStatus(false),
                                  child: Obx(() {
                                    final isActive = controller.selectedWorkStatus.value == false;

                                    return Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: isActive ? MainColor.blueNormal : Colors.transparent,
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color: SecondaryColor.neutral300, width: 2),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          "Tidak Sesuai",
                                          style: Get.textTheme.labelMedium!.copyWith(
                                            color: isActive ? SecondaryColor.neutral600 : SecondaryColor.neutral500,
                                            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                                SizedBox(width: 28.w),
                                GestureDetector(
                                  onTap: () => controller.selectedWorkStatus(true),
                                  child: Obx(() {
                                    final isActive = controller.selectedWorkStatus.value == true;

                                    return Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: isActive ? MainColor.blueNormal : Colors.transparent,
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color: SecondaryColor.neutral300, width: 2),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          "Sesuai",
                                          style: Get.textTheme.labelMedium!.copyWith(
                                            color: isActive ? SecondaryColor.neutral600 : SecondaryColor.neutral500,
                                            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: Get.textTheme.labelMedium!.copyWith(
                                color: SecondaryColor.neutral500,
                                fontWeight: FontWeight.w600,
                              ),
                              children: <TextSpan>[
                                TextSpan(text: 'Ket: '),
                                TextSpan(
                                  text: 'None',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Text("Foto Lapangan", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(height: 12),
                  (controller.reportData.value?.reportPhoto?.length ?? 0) > 0
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1,
                          ),
                          itemCount: controller.reportData.value?.reportPhoto?.length,
                          itemBuilder: (context, index) {
                            final imageUrl =
                                "${AppConstants.baseImageUrl}${controller.reportData.value?.reportPhoto?[index].url}";

                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey,
                                    child: const Center(child: Icon(Icons.error, color: Colors.white)),
                                  );
                                },
                              ),
                            );
                          },
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: Get.size.width * 0.80,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MainColor.blueNormal,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                        ),
                        onPressed: () {
                          controller.createCustomerReport(context);
                        },
                        child: Text(
                          "Submit",
                          style: Get.textTheme.labelMedium!.copyWith(
                            color: SecondaryColor.white,
                            fontWeight: FontWeight.bold,
                          ),
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
    });
  }
}
