import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/widgets/build_custom_dropdown.dart';
import 'package:bpr_pms/app/widgets/build_custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/auth_register_controller.dart';

class AuthRegisterView extends GetView<AuthRegisterController> {
  const AuthRegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(alignment: Alignment.topCenter, child: Image.asset(ImageAssets.logoBpr, scale: 12)),
                  SizedBox(height: 64),
                  Text(
                    "Daftar",
                    style: Get.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w600, color: MainColor.blueNormal),
                  ),
                  SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama",
                        style: Get.textTheme.labelMedium!.copyWith(letterSpacing: 1, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      BuildCustomTextFormField(
                        hintText: "Masukkan nama...",
                        controller: controller.nameController,
                        maxLines: 1,
                        isReadOnly: false,
                        isEnable: true,
                        withInputFormatter: false,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Username",
                        style: Get.textTheme.labelMedium!.copyWith(letterSpacing: 1, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      BuildCustomTextFormField(
                        hintText: "Masukkan username...",
                        controller: controller.usernameController,
                        maxLines: 1,
                        isReadOnly: false,
                        isEnable: true,
                        withInputFormatter: false,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Type",
                        style: Get.textTheme.labelMedium!.copyWith(letterSpacing: 1, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: controller.typeAccountList.value.map((data) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: GestureDetector(
                                onTap: () => controller.useTypeAccount(data),
                                child: Row(
                                  children: [
                                    Icon(
                                      (controller.pickTypeAccount.value == data)
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_off,
                                      size: 20,
                                      color: (controller.pickTypeAccount.value == data)
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
                      ),
                      SizedBox(height: 16),
                      Text(
                        controller.pickTypeAccount.value == 'AM' ? "Wilayah" : "Kantor",
                        style: Get.textTheme.labelMedium!.copyWith(letterSpacing: 1, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      controller.pickTypeAccount.value == 'AM'
                          ? BuildDropdown(
                              hintText: "Pilih Wilayah",
                              selectedValue: controller.selectedItemDropdownDistrict.value,
                              selectedLabel:
                                  controller.itemDropdownDistrict.value.firstWhereOrNull(
                                    (item) => item["value"] == controller.selectedItemDropdownDistrict.value,
                                  )?["label"] ??
                                  '',
                              itemDropdown: controller.itemDropdownDistrict.value,
                              onChanged: (value) => {
                                if (value != null) {controller.changeSelectedItemDropdownDistrict(value)},
                              },
                            )
                          : BuildDropdown(
                              hintText: "Pilih Kantor",
                              selectedValue: controller.selectedItemDropdownOffice.value,
                              selectedLabel:
                                  controller.itemDropdownOffice.value.firstWhereOrNull(
                                    (item) => item["value"] == controller.selectedItemDropdownOffice.value,
                                  )?["label"] ??
                                  '',
                              itemDropdown: controller.itemDropdownOffice.value,
                              onChanged: (value) => {
                                if (value != null) {controller.changeSelectedItemDropdownOffice(value)},
                              },
                            ),
                      SizedBox(height: 16),
                      Text(
                        "Password",
                        style: Get.textTheme.labelMedium!.copyWith(letterSpacing: 1, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      BuildCustomTextFormField(
                        hintText: "Buat password...",
                        controller: controller.passwordController,
                        maxLines: 1,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: !controller.isPasswordVisible.value,
                        suffixIcon: IconButton(
                          onPressed: () => controller.togglePasswordVisible(),
                          icon: controller.isPasswordVisible.value
                              ? SvgPicture.asset(IconAssets.eye, height: 20.h)
                              : SvgPicture.asset(IconAssets.eyeClosed, height: 20.h),
                        ),
                        isReadOnly: false,
                        isEnable: true,
                        withInputFormatter: false,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Konfirmasi Password",
                        style: Get.textTheme.labelMedium!.copyWith(letterSpacing: 1, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      BuildCustomTextFormField(
                        hintText: "Ketikkan ulang password...",
                        controller: controller.confirmPasswordController,
                        maxLines: 1,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: !controller.isConfirmPasswordVisible.value,
                        suffixIcon: IconButton(
                          onPressed: () => controller.toggleConfirmPasswordVisible(),
                          icon: controller.isConfirmPasswordVisible.value
                              ? SvgPicture.asset(IconAssets.eye, height: 20.h)
                              : SvgPicture.asset(IconAssets.eyeClosed, height: 20.h),
                        ),
                        isReadOnly: false,
                        isEnable: true,
                        withInputFormatter: false,
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: MainColor.blueNormal,
                      disabledBackgroundColor: SecondaryColor.neutral500,
                      minimumSize: Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Daftar",
                            style: Get.textTheme.labelMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: SecondaryColor.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sudah punya akun? ", style: Get.textTheme.bodyMedium!),
                      GestureDetector(
                        child: Text("Masuk", style: Get.textTheme.bodyMedium!.copyWith(color: MainColor.blueNormal)),
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
