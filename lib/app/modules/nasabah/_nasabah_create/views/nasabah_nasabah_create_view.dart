import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/modules/nasabah/controllers/nasabah_controller.dart';
import 'package:bpr_pms/app/widgets/build_custom_dropdown.dart';
import 'package:bpr_pms/app/widgets/build_validation_error_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/nasabah_nasabah_create_controller.dart';

class NasabahNasabahCreateView extends GetView<NasabahNasabahCreateController> {
  const NasabahNasabahCreateView({super.key});
  @override
  Widget build(BuildContext context) {
    final NasabahController nasabahController = Get.find<NasabahController>();

    return Obx(() {
      final isFormValid = controller.isFormValid.value;

      final VoidCallback? submitAction = (isFormValid && !controller.isLoading.value)
          ? () => controller.createCustomer(context)
          : null;

      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Tambah Nasabah',
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
                nasabahController.refreshData(Get.context!);
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
                                  style: Get.textTheme.labelMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                      BuildValidationErrorText(
                        errorMessage: controller.validationErrors['customer,name'],
                        alignmentWidth: Get.size.width * 0.22,
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
                                  style: Get.textTheme.labelMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                      BuildValidationErrorText(
                        errorMessage: controller.validationErrors['customer,ktp_number'],
                        alignmentWidth: Get.size.width * 0.22,
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
                                  style: Get.textTheme.labelMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(width: Get.size.width * 0.02),
                              Expanded(
                                child: TextField(
                                  controller: controller.dobController,
                                  readOnly: true,
                                  onTap: () async {
                                    FocusScope.of(context).unfocus();
                                    await controller.pickDob(context);
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Pilih tanggal lahir",
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
                      BuildValidationErrorText(
                        errorMessage: controller.validationErrors['customer,date_of_birth'],
                        alignmentWidth: Get.size.width * 0.22,
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
                                  style: Get.textTheme.labelMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(width: Get.size.width * 0.02),
                              Expanded(
                                child: TextField(
                                  controller: controller.phoneNumberController,
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))],
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
                      BuildValidationErrorText(
                        errorMessage: controller.validationErrors['customer,phone_number'],
                        alignmentWidth: Get.size.width * 0.22,
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
                                  style: Get.textTheme.labelMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                      BuildValidationErrorText(
                        errorMessage: controller.validationErrors['customer,village'],
                        alignmentWidth: Get.size.width * 0.22,
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
                                  style: Get.textTheme.labelMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                      BuildValidationErrorText(
                        errorMessage: controller.validationErrors['customer,rt_rw'],
                        alignmentWidth: Get.size.width * 0.22,
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
                                  style: Get.textTheme.labelMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                      BuildValidationErrorText(
                        errorMessage: controller.validationErrors['customer,address'],
                        alignmentWidth: Get.size.width * 0.22,
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
                      BuildValidationErrorText(
                        errorMessage: controller.validationErrors['customer,work_type'],
                        alignmentWidth: Get.size.width * 0.22,
                      ),
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
                                  BuildValidationErrorText(
                                    errorMessage: controller.validationErrors['business,business_type'],
                                    alignmentWidth: Get.size.width * 0.22,
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
                                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
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
                                  BuildValidationErrorText(
                                    errorMessage: controller.validationErrors['business,employee_count'],
                                    alignmentWidth: Get.size.width * 0.22,
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
                                                    inputFormatters: [CurrencyInputFormatter()],
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
                                            selectedValue: "bulan",
                                            selectedLabel:
                                                controller.itemsTypeIncomeJob.value.firstWhereOrNull(
                                                  (item) => item["value"] == "bulan",
                                                )?["label"] ??
                                                '',
                                            itemDropdown: controller.itemsTypeIncomeJob.value,
                                            onChanged: null,
                                            buttonHeight: null,
                                            buttonPadding: EdgeInsets.only(left: 8, right: 8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  BuildValidationErrorText(
                                    errorMessage: controller.validationErrors['business,revenue'],
                                    alignmentWidth: Get.size.width * 0.22,
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
                                  BuildValidationErrorText(
                                    errorMessage: controller.validationErrors['employee,company_name'],
                                    alignmentWidth: Get.size.width * 0.22,
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
                                  BuildValidationErrorText(
                                    errorMessage: controller.validationErrors['employee,company_address'],
                                    alignmentWidth: Get.size.width * 0.22,
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
                                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))],
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
                                  BuildValidationErrorText(
                                    errorMessage: controller.validationErrors['employee,company_phone'],
                                    alignmentWidth: Get.size.width * 0.22,
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
                                  BuildValidationErrorText(
                                    errorMessage: controller.validationErrors['employee,work'],
                                    alignmentWidth: Get.size.width * 0.22,
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
                                  BuildValidationErrorText(
                                    errorMessage: controller.validationErrors['employee,position'],
                                    alignmentWidth: Get.size.width * 0.22,
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
                                                    inputFormatters: [CurrencyInputFormatter()],
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
                                            selectedValue: "bulan",
                                            selectedLabel:
                                                controller.itemsTypeIncomeJob.value.firstWhereOrNull(
                                                  (item) => item["value"] == "bulan",
                                                )?["label"] ??
                                                '',
                                            itemDropdown: controller.itemsTypeIncomeJob.value,
                                            onChanged: null,
                                            buttonHeight: null,
                                            buttonPadding: EdgeInsets.only(left: 8, right: 8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  BuildValidationErrorText(
                                    errorMessage: controller.validationErrors['employee,salary'],
                                    alignmentWidth: Get.size.width * 0.22,
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
                                  BuildValidationErrorText(
                                    errorMessage: controller.validationErrors['non_employee,work'],
                                    alignmentWidth: Get.size.width * 0.22,
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
                                                    inputFormatters: [CurrencyInputFormatter()],
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
                                  BuildValidationErrorText(
                                    errorMessage: controller.validationErrors['non_employee,salary'],
                                    alignmentWidth: Get.size.width * 0.22,
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
                              backgroundColor: MainColor.blue5,
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
                                      "Tambahkan",
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
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
