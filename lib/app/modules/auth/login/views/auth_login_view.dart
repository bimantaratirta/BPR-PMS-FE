import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:bpr_pms/app/widgets/build_custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/auth_login_controller.dart';

class AuthLoginView extends GetView<AuthLoginController> {
  const AuthLoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(alignment: Alignment.topCenter, child: Image.asset(ImageAssets.logoBpr, scale: 12)),
                  SizedBox(height: 64),
                  Text(
                    "Masuk",
                    style: Get.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w600, color: MainColor.blueNormal),
                  ),
                  SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      controller.validationErrors['username'] != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Text(
                                  controller.validationErrors['username'] ?? '',
                                  style: Get.textTheme.bodySmall!.copyWith(color: Colors.red),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      SizedBox(height: 16),
                      Text(
                        "Password",
                        style: Get.textTheme.labelMedium!.copyWith(letterSpacing: 1, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      BuildCustomTextFormField(
                        hintText: "Masukkan password...",
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
                      controller.validationErrors['password'] != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Text(
                                  controller.validationErrors['password'] ?? '',
                                  style: Get.textTheme.bodySmall!.copyWith(color: Colors.red),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("Lupa Password?", style: Get.textTheme.bodyMedium!),
                  ),
                  SizedBox(height: 32),
                  Obx(() {
                    final isFormValid = controller.isFormValid.value;

                    final VoidCallback? action = (isFormValid && !controller.isLoading.value)
                        ? () => controller.login(context)
                        : null;
                    return ElevatedButton(
                      onPressed: action,
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
                            if (controller.isLoading.value)
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: const CircularProgressIndicator(color: SecondaryColor.white, strokeWidth: 2),
                              )
                            else
                              Text(
                                "Masuk",
                                style: Get.textTheme.labelMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: SecondaryColor.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Belum punya akun? ", style: Get.textTheme.bodyMedium!),
                      GestureDetector(
                        child: Text("Daftar", style: Get.textTheme.bodyMedium!.copyWith(color: MainColor.blueNormal)),
                        onTap: () {
                          Get.toNamed(Routes.AUTH_REGISTER);
                        },
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
