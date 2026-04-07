import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/modules/nasabah/_nasabah_detail/widgets/nasabah_changes_item.dart';
import 'package:bpr_pms/app/modules/nasabah/controllers/nasabah_controller.dart';
import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/nasabah_nasabah_detail_controller.dart';

class NasabahNasabahDetailView extends GetView<NasabahNasabahDetailController> {
  const NasabahNasabahDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final bool isNasabahControllerRegistered = Get.isRegistered<NasabahController>();
    NasabahController? nasabahController;
    if (isNasabahControllerRegistered) {
      nasabahController = Get.find<NasabahController>();
    }

    final String? itemId = Get.parameters['id'];

    if (itemId != null && controller.id.value != itemId) {
      controller.id.value = itemId;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        controller.customerData.value = await controller.getCustomerById(Get.context!, itemId);
      });
    }

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Detail Data Nasabah',
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
                nasabahController?.refreshData(Get.context!);
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
                            isNasabahControllerRegistered
                                ? GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.nasabahEdit(controller.id.value));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 8),
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color: SecondaryColor.neutral300),
                                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5)],
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            height: 16.h,
                                            IconAssets.pencil,
                                            color: SecondaryColor.neutral500,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "Edit",
                                            style: Get.textTheme.labelMedium!.copyWith(
                                              color: SecondaryColor.neutral500,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => controller.toggleHistoryExpansion(),
                              behavior: HitTestBehavior.opaque,
                              child: Row(
                                children: [
                                  Text(
                                    controller.isHistoryExpanded.value
                                        ? "Tutup Histori Perubahan Data"
                                        : "Lihat Histori Perubahan Data",
                                    style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(controller.isHistoryExpanded.value ? Icons.expand_less : Icons.expand_more, size: 20),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: controller.isHistoryExpanded.value,
                              child: AnimatedCrossFade(
                                crossFadeState: controller.isHistoryExpanded.value
                                    ? CrossFadeState.showFirst
                                    : CrossFadeState.showSecond,
                                duration: Duration(milliseconds: 300),
                                secondChild: SizedBox.shrink(),
                                firstChild: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 12),
                                    controller.customerData.value?.updateLogs != null &&
                                            controller.customerData.value!.updateLogs!.isNotEmpty
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: controller.customerData.value!.updateLogs!
                                                .map((log) => NasabahChangesItem(log: log))
                                                .toList(),
                                          )
                                        : Text(
                                            "Tidak ada histori perubahan data.",
                                            style: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.neutral500),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        isNasabahControllerRegistered
                            ? Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: Get.size.width * 0.80,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MainColor.blue5,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                                    ),
                                    onPressed: () {
                                      Get.toNamed(Routes.nasabahReport(controller.id.value));
                                    },
                                    child: Text(
                                      "Buat Laporan",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
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
