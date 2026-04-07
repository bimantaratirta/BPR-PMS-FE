import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/widgets/build_custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/profile_profile_change_password_controller.dart';

class ProfileProfileChangePasswordView extends GetView<ProfileProfileChangePasswordController> {
  const ProfileProfileChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ganti Password',
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Password Baru",
                          style: Get.textTheme.labelMedium!.copyWith(letterSpacing: 1, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8),
                        BuildCustomTextFormField(
                          hintText: "Masukkan password baru...",
                          controller: controller.newPasswordController,
                          maxLines: 1,
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
                          hintText: "Masukkan password...",
                          controller: controller.confirmNewPasswordController,
                          maxLines: 1,
                          isReadOnly: false,
                          isEnable: true,
                          withInputFormatter: false,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: Get.size.width * 0.80,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MainColor.blue5,
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
