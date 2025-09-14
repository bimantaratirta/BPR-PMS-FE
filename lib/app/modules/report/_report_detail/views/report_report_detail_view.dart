import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/report_report_detail_controller.dart';

class ReportReportDetailView extends GetView<ReportReportDetailController> {
  const ReportReportDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = List.generate(15, (index) => 'https://picsum.photos/id/${10 + index}/200/300');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Detail Laporan',
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
                Text("Data Kontak", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 12),
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
                          "081234567890",
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
                          "Pertanian",
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
                          "Rp. 5.000.000 /bulan",
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
                          "Bad",
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
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        imageUrls[index],
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
