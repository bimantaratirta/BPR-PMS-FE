import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:bpr_pms/app/widgets/build_validation_error_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/profile_profile_detail_controller.dart';

class ProfileProfileDetailView extends GetView<ProfileProfileDetailController> {
  const ProfileProfileDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profil Pengguna',
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
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Get.size.height * 0.02),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: MainColor.blueNormalActive,
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  SizedBox(height: Get.size.height * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(color: SecondaryColor.neutral100, borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                          child: Row(
                            children: [
                              SizedBox(
                                width: Get.size.width * 0.2,
                                child: Text(
                                  "Nama",
                                  style: Get.textTheme.labelMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: Get.size.width * 0.02),
                              Expanded(
                                child: TextField(
                                  controller: controller.nameController,
                                  decoration: InputDecoration(
                                    hintText: "Masukkan Nama...",
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
                        errorMessage: controller.validationErrors['name'],
                        alignmentWidth: Get.size.width * 0.22,
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(color: SecondaryColor.neutral100, borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                          child: Row(
                            children: [
                              SizedBox(
                                width: Get.size.width * 0.2,
                                child: Text(
                                  "Username",
                                  style: Get.textTheme.labelMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: Get.size.width * 0.02),
                              Expanded(
                                child: TextField(
                                  controller: controller.usernameController,
                                  decoration: InputDecoration(
                                    hintText: "Masukkan Username...",
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
                        errorMessage: controller.validationErrors['username'],
                        alignmentWidth: Get.size.width * 0.22,
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(color: SecondaryColor.neutral100, borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                          child: Row(
                            children: [
                              SizedBox(
                                width: Get.size.width * 0.2,
                                child: Text(
                                  "Type",
                                  style: Get.textTheme.labelMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: Get.size.width * 0.02),
                              Expanded(
                                child: TextField(
                                  readOnly: true,
                                  enabled: false,
                                  controller: controller.typeController,
                                  decoration: InputDecoration(
                                    hintText: "Masukkan Tipe...",
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
                      authController.pickRole.value != UserRole.am && authController.pickRole.value != UserRole.direksi
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: SecondaryColor.neutral100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: Get.size.width * 0.2,
                                          child: Text(
                                            "Supervisor",
                                            style: Get.textTheme.labelMedium!.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Get.size.width * 0.02),
                                        Expanded(
                                          child: TextField(
                                            readOnly: true,
                                            enabled: false,
                                            controller: controller.supervisorController,
                                            decoration: InputDecoration(
                                              hintText: "Masukkan Supervisor...",
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
                              ],
                            )
                          : const SizedBox.shrink(),
                      authController.pickRole.value != UserRole.am && authController.pickRole.value != UserRole.direksi
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: SecondaryColor.neutral100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: Get.size.width * 0.2,
                                          child: Text(
                                            "Cabang",
                                            style: Get.textTheme.labelMedium!.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Get.size.width * 0.02),
                                        Expanded(
                                          child: TextField(
                                            readOnly: true,
                                            enabled: false,
                                            controller: controller.officeController,
                                            decoration: InputDecoration(
                                              hintText: "Masukkan Cabang...",
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
                              ],
                            )
                          : const SizedBox.shrink(),
                      authController.pickRole.value != UserRole.direksi
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: SecondaryColor.neutral100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: Get.size.width * 0.2,
                                          child: Text(
                                            "Wilayah",
                                            style: Get.textTheme.labelMedium!.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Get.size.width * 0.02),
                                        Expanded(
                                          child: TextField(
                                            readOnly: true,
                                            enabled: false,
                                            controller: controller.districtController,
                                            decoration: InputDecoration(
                                              hintText: "Masukkan Wilayah...",
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
                              ],
                            )
                          : const SizedBox.shrink(),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: Get.size.width * 0.80,
                          child: Obx(() {
                            final isFormValid = controller.isFormValid.value;

                            final VoidCallback? action = (isFormValid && !controller.isLoading.value)
                                ? () => controller.updateProfile(context)
                                : null;
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MainColor.blueNormal,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                              ),
                              onPressed: action,
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
                                      "Simpan",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }),
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
