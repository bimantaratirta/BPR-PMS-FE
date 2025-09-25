import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/widgets/build_custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/nasabah_nasabah_edit_controller.dart';

class NasabahNasabahEditView extends GetView<NasabahNasabahEditController> {
  const NasabahNasabahEditView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Data Nasabah',
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
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Get.size.height * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Data Identitas", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                        Text(
                          " *",
                          style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600, color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: SecondaryColor.neutral100,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4))],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.size.width * 0.25,
                              child: Text(
                                "Nama",
                                style: Get.textTheme.labelMedium!.copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(width: Get.size.width * 0.02),
                            Expanded(
                              child: TextField(
                                controller: controller.nameController,
                                decoration: InputDecoration(
                                  hintText: "Masukkan nama lengkap...",
                                  hintStyle: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.neutral400),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                style: Get.textTheme.labelMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: SecondaryColor.neutral100,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4))],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.size.width * 0.25,
                              child: Text(
                                "Nomor KTP",
                                style: Get.textTheme.labelMedium!.copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(width: Get.size.width * 0.02),
                            Expanded(
                              child: TextField(
                                controller: controller.identityNumberController,
                                decoration: InputDecoration(
                                  hintText: "Masukkan nomor KTP...",
                                  hintStyle: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.neutral400),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                style: Get.textTheme.labelMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: SecondaryColor.neutral100,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4))],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.size.width * 0.25,
                              child: Text(
                                "Tanggal Lahir",
                                style: Get.textTheme.labelMedium!.copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(width: Get.size.width * 0.02),
                            Expanded(
                              child: TextField(
                                controller: controller.dobController,
                                decoration: InputDecoration(
                                  hintText: "Masukkan tanggal lahir...",
                                  hintStyle: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.neutral400),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                style: Get.textTheme.labelMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: SecondaryColor.neutral100,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4))],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.size.width * 0.25,
                              child: Text(
                                "No Handphone",
                                style: Get.textTheme.labelMedium!.copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(width: Get.size.width * 0.02),
                            Expanded(
                              child: TextField(
                                controller: controller.phoneNumberController,
                                decoration: InputDecoration(
                                  hintText: "Masukkan nomor handphone...",
                                  hintStyle: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.neutral400),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                style: Get.textTheme.labelMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.size.height * 0.02),
                    Text("Alamat Domisili", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: SecondaryColor.neutral100,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4))],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.size.width * 0.25,
                              child: Text(
                                "Desa",
                                style: Get.textTheme.labelMedium!.copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(width: Get.size.width * 0.02),
                            Expanded(
                              child: TextField(
                                controller: controller.villageController,
                                decoration: InputDecoration(
                                  hintText: "Masukkan desa...",
                                  hintStyle: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.neutral400),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                style: Get.textTheme.labelMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: SecondaryColor.neutral100,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4))],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.size.width * 0.25,
                              child: Text(
                                "RT/RW",
                                style: Get.textTheme.labelMedium!.copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(width: Get.size.width * 0.02),
                            Expanded(
                              child: TextField(
                                controller: controller.neighborhoodUnitController,
                                decoration: InputDecoration(
                                  hintText: "Masukkan RT/RW...",
                                  hintStyle: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.neutral400),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                style: Get.textTheme.labelMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: SecondaryColor.neutral100,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4))],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.size.width * 0.25,
                              child: Text(
                                "Alamat",
                                style: Get.textTheme.labelMedium!.copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(width: Get.size.width * 0.02),
                            Expanded(
                              child: TextField(
                                controller: controller.addressController,
                                decoration: InputDecoration(
                                  hintText: "Masukkan alamat...",
                                  hintStyle: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.neutral400),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                style: Get.textTheme.labelMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.size.height * 0.02),
                    Text("Tipe Pekerjaan", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    Obx(() {
                      return BuildDropdown(
                        hintText: "Pilih tipe pekerjaan...",
                        selectedValue: controller.selectedItemTypeJob.value,
                        selectedLabel:
                            controller.itemsTypeJob.value.firstWhereOrNull(
                              (item) => item["value"] == controller.selectedItemTypeJob.value,
                            )?["label"] ??
                            '',
                        itemDropdown: controller.itemsTypeJob.value,
                        onChanged: (value) => {
                          if (value != null) {controller.changeSelectedItemTypeJob(value)},
                        },
                      );
                    }),
                    Obx(() {
                      return controller.selectedItemTypeJob.value == 'businessman'
                          ? Column(
                              children: [
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: SecondaryColor.neutral100,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4)),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: Get.size.width * 0.25,
                                          child: Text(
                                            "Jenis Usaha",
                                            style: Get.textTheme.labelMedium!.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Get.size.width * 0.02),
                                        Expanded(
                                          child: TextField(
                                            controller: controller.detailTypeJob,
                                            decoration: InputDecoration(
                                              hintText: "Masukkan jenis usaha...",
                                              hintStyle: Get.textTheme.labelMedium!.copyWith(
                                                color: SecondaryColor.neutral400,
                                              ),
                                              border: InputBorder.none,
                                              isDense: true,
                                            ),
                                            style: Get.textTheme.labelMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: SecondaryColor.neutral100,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4)),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: Get.size.width * 0.25,
                                          child: Text(
                                            "Total Karyawan",
                                            style: Get.textTheme.labelMedium!.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Get.size.width * 0.02),
                                        Expanded(
                                          child: TextField(
                                            controller: controller.totalEmployees,
                                            decoration: InputDecoration(
                                              hintText: "Masukkan total karyawan...",
                                              hintStyle: Get.textTheme.labelMedium!.copyWith(
                                                color: SecondaryColor.neutral400,
                                              ),
                                              border: InputBorder.none,
                                              isDense: true,
                                            ),
                                            style: Get.textTheme.labelMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: SecondaryColor.neutral100,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4)),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: Get.size.width * 0.25,
                                                child: Text(
                                                  "Pendapatan",
                                                  style: Get.textTheme.labelMedium!.copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: Get.size.width * 0.02),
                                              Expanded(
                                                child: TextField(
                                                  controller: controller.jobIncome,
                                                  decoration: InputDecoration(
                                                    hintText: "Masukkan pendapatan...",
                                                    hintStyle: Get.textTheme.labelMedium!.copyWith(
                                                      color: SecondaryColor.neutral400,
                                                    ),
                                                    border: InputBorder.none,
                                                    isDense: true,
                                                  ),
                                                  style: Get.textTheme.labelMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.size.width * 0.25,
                                        child: BuildDropdown(
                                          hintText: "Pilih satuan...",
                                          selectedValue: controller.selectedItemTypeIncomeJob.value,
                                          selectedLabel:
                                              controller.itemsTypeIncomeJob.value.firstWhereOrNull(
                                                (item) => item["value"] == controller.selectedItemTypeIncomeJob.value,
                                              )?["label"] ??
                                              '',
                                          itemDropdown: controller.itemsTypeIncomeJob.value,
                                          onChanged: (value) => {
                                            if (value != null) {controller.changeSelectedItemTypeIncomeJob(value)},
                                          },
                                          buttonHeight: null,
                                          buttonPadding: EdgeInsets.only(left: 8, right: 8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : controller.selectedItemTypeJob.value == 'permanentEmployee'
                          ? Column(
                              children: [
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: SecondaryColor.neutral100,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4)),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: Get.size.width * 0.25,
                                          child: Text(
                                            "Perusahaan",
                                            style: Get.textTheme.labelMedium!.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Get.size.width * 0.02),
                                        Expanded(
                                          child: TextField(
                                            controller: controller.jobCompanyName,
                                            decoration: InputDecoration(
                                              hintText: "Masukkan nama perusahaan...",
                                              hintStyle: Get.textTheme.labelMedium!.copyWith(
                                                color: SecondaryColor.neutral400,
                                              ),
                                              border: InputBorder.none,
                                              isDense: true,
                                            ),
                                            style: Get.textTheme.labelMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: SecondaryColor.neutral100,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4)),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: Get.size.width * 0.25,
                                          child: Text(
                                            "Alamat",
                                            style: Get.textTheme.labelMedium!.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Get.size.width * 0.02),
                                        Expanded(
                                          child: TextField(
                                            controller: controller.jobAddress,
                                            decoration: InputDecoration(
                                              hintText: "Masukkan alamat perusahaan...",
                                              hintStyle: Get.textTheme.labelMedium!.copyWith(
                                                color: SecondaryColor.neutral400,
                                              ),
                                              border: InputBorder.none,
                                              isDense: true,
                                            ),
                                            style: Get.textTheme.labelMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: SecondaryColor.neutral100,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4)),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: Get.size.width * 0.25,
                                          child: Text(
                                            "No Handphone",
                                            style: Get.textTheme.labelMedium!.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Get.size.width * 0.02),
                                        Expanded(
                                          child: TextField(
                                            controller: controller.jobPhoneNumber,
                                            decoration: InputDecoration(
                                              hintText: "Masukkan no handphone perusahaan...",
                                              hintStyle: Get.textTheme.labelMedium!.copyWith(
                                                color: SecondaryColor.neutral400,
                                              ),
                                              border: InputBorder.none,
                                              isDense: true,
                                            ),
                                            style: Get.textTheme.labelMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: SecondaryColor.neutral100,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4)),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: Get.size.width * 0.25,
                                          child: Text(
                                            "Pekerjaan",
                                            style: Get.textTheme.labelMedium!.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Get.size.width * 0.02),
                                        Expanded(
                                          child: TextField(
                                            controller: controller.jobName,
                                            decoration: InputDecoration(
                                              hintText: "Masukkan nama pekerjaan...",
                                              hintStyle: Get.textTheme.labelMedium!.copyWith(
                                                color: SecondaryColor.neutral400,
                                              ),
                                              border: InputBorder.none,
                                              isDense: true,
                                            ),
                                            style: Get.textTheme.labelMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: SecondaryColor.neutral100,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4)),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: Get.size.width * 0.25,
                                          child: Text(
                                            "Posisi",
                                            style: Get.textTheme.labelMedium!.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Get.size.width * 0.02),
                                        Expanded(
                                          child: TextField(
                                            controller: controller.jobPosition,
                                            decoration: InputDecoration(
                                              hintText: "Masukkan posisi pekerjaan...",
                                              hintStyle: Get.textTheme.labelMedium!.copyWith(
                                                color: SecondaryColor.neutral400,
                                              ),
                                              border: InputBorder.none,
                                              isDense: true,
                                            ),
                                            style: Get.textTheme.labelMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: SecondaryColor.neutral100,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4)),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: Get.size.width * 0.25,
                                                child: Text(
                                                  "Pendapatan",
                                                  style: Get.textTheme.labelMedium!.copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: Get.size.width * 0.02),
                                              Expanded(
                                                child: TextField(
                                                  controller: controller.jobIncome,
                                                  decoration: InputDecoration(
                                                    hintText: "Masukkan pendapatan...",
                                                    hintStyle: Get.textTheme.labelMedium!.copyWith(
                                                      color: SecondaryColor.neutral400,
                                                    ),
                                                    border: InputBorder.none,
                                                    isDense: true,
                                                  ),
                                                  style: Get.textTheme.labelMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.size.width * 0.25,
                                        child: BuildDropdown(
                                          hintText: "Pilih satuan...",
                                          selectedValue: controller.selectedItemTypeIncomeJob.value,
                                          selectedLabel:
                                              controller.itemsTypeIncomeJob.value.firstWhereOrNull(
                                                (item) => item["value"] == controller.selectedItemTypeIncomeJob.value,
                                              )?["label"] ??
                                              '',
                                          itemDropdown: controller.itemsTypeIncomeJob.value,
                                          onChanged: (value) => {
                                            if (value != null) {controller.changeSelectedItemTypeIncomeJob(value)},
                                          },
                                          buttonHeight: null,
                                          buttonPadding: EdgeInsets.only(left: 8, right: 8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : controller.selectedItemTypeJob.value == 'freelancer'
                          ? Column(
                              children: [
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: SecondaryColor.neutral100,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4)),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: Get.size.width * 0.25,
                                          child: Text(
                                            "Pekerjaan",
                                            style: Get.textTheme.labelMedium!.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Get.size.width * 0.02),
                                        Expanded(
                                          child: TextField(
                                            controller: controller.jobName,
                                            decoration: InputDecoration(
                                              hintText: "Masukkan nama pekerjaan...",
                                              hintStyle: Get.textTheme.labelMedium!.copyWith(
                                                color: SecondaryColor.neutral400,
                                              ),
                                              border: InputBorder.none,
                                              isDense: true,
                                            ),
                                            style: Get.textTheme.labelMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: SecondaryColor.neutral100,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0, 4)),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: Get.size.width * 0.25,
                                                child: Text(
                                                  "Pendapatan",
                                                  style: Get.textTheme.labelMedium!.copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: Get.size.width * 0.02),
                                              Expanded(
                                                child: TextField(
                                                  controller: controller.jobIncome,
                                                  decoration: InputDecoration(
                                                    hintText: "Masukkan pendapatan...",
                                                    hintStyle: Get.textTheme.labelMedium!.copyWith(
                                                      color: SecondaryColor.neutral400,
                                                    ),
                                                    border: InputBorder.none,
                                                    isDense: true,
                                                  ),
                                                  style: Get.textTheme.labelMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.size.width * 0.25,
                                        child: BuildDropdown(
                                          hintText: "Pilih satuan...",
                                          selectedValue: controller.selectedItemTypeIncomeJob.value,
                                          selectedLabel:
                                              controller.itemsTypeIncomeJob.value.firstWhereOrNull(
                                                (item) => item["value"] == controller.selectedItemTypeIncomeJob.value,
                                              )?["label"] ??
                                              '',
                                          itemDropdown: controller.itemsTypeIncomeJob.value,
                                          onChanged: (value) => {
                                            if (value != null) {controller.changeSelectedItemTypeIncomeJob(value)},
                                          },
                                          buttonHeight: null,
                                          buttonPadding: EdgeInsets.only(left: 8, right: 8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : SizedBox();
                    }),
                    SizedBox(height: Get.size.height * 0.02),
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
                            "Simpan",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
