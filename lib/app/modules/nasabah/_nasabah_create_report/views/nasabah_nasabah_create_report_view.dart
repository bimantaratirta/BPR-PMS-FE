import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/modules/nasabah/_nasabah_detail/controllers/nasabah_nasabah_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/nasabah_nasabah_create_report_controller.dart';

class NasabahNasabahCreateReportView extends GetView<NasabahNasabahCreateReportController> {
  const NasabahNasabahCreateReportView({super.key});
  @override
  Widget build(BuildContext context) {
    final NasabahNasabahDetailController nasabahDetailController = Get.find<NasabahNasabahDetailController>();

    final String? itemId = Get.parameters['id'];

    if (itemId != null && controller.id.value != itemId) {
      controller.id.value = itemId;
      controller.customerData.value = nasabahDetailController.customerData.value;
    }

    return Obx(() {
      final isFormValid = controller.isFormValid.value;

      final VoidCallback? submitAction = (isFormValid && !controller.isLoading.value)
          ? () => controller.createCustomerReport(context)
          : null;

      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Form Pengajuan Laporan',
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
        body: itemId == null
            ? SizedBox.shrink()
            : controller.isLoading.isTrue
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 25),
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Data Identitas", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                          ],
                        ),
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
                                  controller.customerData.value?.name ?? "-",
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
                                  controller.customerData.value?.ktpNumber ?? "-",
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
                                  controller.customerData.value?.dateOfBirth != null
                                      ? Helper().formatDateTimeToID(controller.customerData.value!.dateOfBirth)
                                      : "-",
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
                                  controller.customerData.value?.phoneNumber ?? "-",
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
                                  controller.customerData.value?.village ?? "-",
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
                                  controller.customerData.value?.rtRw ?? "-",
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
                                  controller.customerData.value?.address ?? "-",
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
                        Text(
                          "Jenis Usaha/Pekerjaan",
                          style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600),
                        ),
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
                                  controller.customerData.value?.workType ?? "-",
                                  style: Get.textTheme.labelMedium!.copyWith(
                                    color: SecondaryColor.neutral500,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        controller.customerData.value?.nonEmployee != null
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
                                            controller.customerData.value?.nonEmployee?.work ?? "-",
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
                                            controller.customerData.value?.nonEmployee?.salary != null
                                                ? "${Helper().formatToRupiah(controller.customerData.value!.nonEmployee!.salary!)} /${controller.customerData.value!.nonEmployee!.salaryFrequency ?? ''}"
                                                : "-",
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
                            : controller.customerData.value?.business != null
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
                                            controller.customerData.value?.business?.businessType ?? "-",
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
                                            controller.customerData.value?.business?.employeeCount != null
                                                ? "${controller.customerData.value!.business!.employeeCount} Orang"
                                                : "-",
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
                                            controller.customerData.value?.business?.revenue != null
                                                ? "${controller.customerData.value!.business!.revenue}/bulan"
                                                : "-",
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
                            : controller.customerData.value?.employee != null
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
                                            controller.customerData.value?.employee?.companyName ?? "-",
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
                                            controller.customerData.value?.employee?.companyAddress ?? "-",
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
                                            controller.customerData.value?.employee?.companyPhone ?? "-",
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
                                            controller.customerData.value?.employee?.work ?? "-",
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
                                            controller.customerData.value?.employee?.position ?? "-",
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
                                            controller.customerData.value?.employee?.salary != null
                                                ? "${Helper().formatToRupiah(controller.customerData.value!.employee!.salary!)} /bulan"
                                                : "-",
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
                        Text("Foto Lapangan", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                        SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => controller.showImageSourceDialog(context),
                          child: Container(
                            width: Get.size.width,
                            height: 150,
                            decoration: BoxDecoration(
                              color: SecondaryColor.neutral100,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5)],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(height: 40.h, IconAssets.imagePlus, color: Colors.black),
                                  const SizedBox(height: 12),
                                  Text(
                                    "Tambahkan Foto (${controller.selectedPhotos.length}/${controller.maxPhotos})",
                                    style: Get.textTheme.labelMedium!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1,
                          ),
                          itemCount: controller.selectedPhotos.length,
                          itemBuilder: (context, index) {
                            final photoFile = controller.selectedPhotos[index];

                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.file(
                                    photoFile,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),

                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () => controller.removePhoto(index),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                        boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 2)],
                                      ),
                                      padding: const EdgeInsets.all(3),
                                      child: const Icon(Icons.close, color: Colors.white, size: 15),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        Text("Penilaian", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                        SizedBox(height: 12),
                        Obx(() {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: controller.evaluationList.value.map((data) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: GestureDetector(
                                    onTap: () => controller.usePickEvaluation(data),
                                    child: Row(
                                      children: [
                                        Icon(
                                          (controller.pickEvaluation.value == data)
                                              ? Icons.radio_button_checked
                                              : Icons.radio_button_off,
                                          size: 20,
                                          color: (controller.pickEvaluation.value == data)
                                              ? MainColor.blueNormal
                                              : SecondaryColor.blackCharcoal,
                                        ),
                                        SizedBox(width: 10),
                                        Text(data, style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: Get.size.width * 0.80,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MainColor.blueNormal,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: submitAction,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (controller.isLoading.value)
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: const CircularProgressIndicator(color: SecondaryColor.white, strokeWidth: 2),
                                      )
                                    else
                                      Text(
                                        "Ajukan Laporan",
                                        style: Get.textTheme.labelMedium!.copyWith(
                                          color: SecondaryColor.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ],
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
