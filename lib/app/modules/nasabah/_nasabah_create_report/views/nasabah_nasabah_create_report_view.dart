import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/nasabah_nasabah_create_report_controller.dart';

class NasabahNasabahCreateReportView extends GetView<NasabahNasabahCreateReportController> {
  const NasabahNasabahCreateReportView({super.key});
  @override
  Widget build(BuildContext context) {
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
                          "John Doe",
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
                          "13400092800984333",
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
                          "23 Desember 2001",
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
                          "08123123123",
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
                          "Ciperna",
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
                          "006/009",
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
                          "Loren ipsum",
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
                          "Pekerja Lepas",
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
                          "Lorem Ipsum dolor",
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
                          "Lorem Ipsum dolor",
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
                Container(
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
                        SizedBox(height: 12),
                        Text(
                          "Tambahkan Foto",
                          style: Get.textTheme.labelMedium!.copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
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
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Ajukan Laporan",
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
