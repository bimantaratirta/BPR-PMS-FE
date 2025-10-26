import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/app_constants.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/modules/report/controllers/report_controller.dart';
import 'package:bpr_pms/app/modules/report/widgets/report_select_status.dart';
import 'package:bpr_pms/app/widgets/build_custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/report_report_detail_controller.dart';

class ReportReportDetailView extends GetView<ReportReportDetailController> {
  const ReportReportDetailView({super.key});
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
            'Detail Laporan',
            style: Get.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: IconButton(
              icon: SvgPicture.asset(height: 16.h, IconAssets.chevronLeft, color: MainColor.blue5),
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
                  SizedBox(height: 12),
                  Text("Data LO", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.size.width * 0.30,
                          child: Text(
                            "LO",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: Get.size.width * 0.02),
                        Expanded(
                          child: Text(
                            controller.reportData.value?.lo?.name ?? "-",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Text("Tipe Nasabah", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.size.width * 0.30,
                          child: Text(
                            controller.reportData.value?.status == "GOOD"
                                ? "Good"
                                : controller.reportData.value?.status == "BAD"
                                ? "Bad"
                                : "Unknown",
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: SecondaryColor.neutral500,
                              fontWeight: FontWeight.w600,
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
                  SizedBox(height: 12),
                  controller.reportData.value?.evaluation != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Karakter", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                            SizedBox(height: 12),
                            BuildCustomTextFormField(
                              hintText: "Tambahkan penilaian...",
                              controller: controller.characterController,
                              maxLines: 6,
                              isReadOnly: true,
                              isEnable: false,
                              withInputFormatter: false,
                              contentPadding: EdgeInsets.all(16),
                            ),
                            ReportSelectStatus(
                              trueLabel: "Good",
                              falseLabel: "Bad",
                              onSelect: (value) => {},
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
                              isReadOnly: true,
                              isEnable: false,
                              withInputFormatter: false,
                              contentPadding: EdgeInsets.all(16),
                            ),
                            ReportSelectStatus(
                              trueLabel: "Good",
                              falseLabel: "Bad",
                              onSelect: (value) => {},
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
                              isReadOnly: true,
                              isEnable: false,
                              withInputFormatter: false,
                              contentPadding: EdgeInsets.all(16),
                            ),
                            ReportSelectStatus(
                              trueLabel: "Good",
                              falseLabel: "Bad",
                              onSelect: (value) => {},
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
                              isReadOnly: true,
                              isEnable: false,
                              withInputFormatter: false,
                              contentPadding: EdgeInsets.all(16),
                            ),
                            ReportSelectStatus(
                              trueLabel: "Good",
                              falseLabel: "Bad",
                              onSelect: (value) => {},
                              selectedStatus: controller.selectedCapitalStatus,
                              falseColor: SecondaryColor.danger600,
                              trueColor: SecondaryColor.success600,
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
