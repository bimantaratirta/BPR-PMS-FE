import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/nasabah_nasabah_detail_controller.dart';

class NasabahNasabahDetailView extends GetView<NasabahNasabahDetailController> {
  const NasabahNasabahDetailView({super.key});
  @override
  Widget build(BuildContext context) {
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
            icon: SvgPicture.asset(height: 16.h, IconAssets.chevronLeft, color: MainColor.blueNormal),
            onPressed: () {
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
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(left: 8),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: SecondaryColor.neutral300),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(height: 16.h, IconAssets.pencil, color: SecondaryColor.neutral500),
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
                    ),
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
                Text("Tipe Pekerjaan", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
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
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: Get.size.width * 0.80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MainColor.blueNormal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Simpan",
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
