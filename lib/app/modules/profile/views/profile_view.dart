import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:bpr_pms/app/widgets/build_navigation/build_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:bpr_pms/app/widgets/dialog/build_custom_dialog.dart';
import 'package:bpr_pms/app/widgets/dialog/content/confirmation_dialog_content.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Obx(() {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: Get.size.height * 0.08, bottom: 25),
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: MainColor.blueNormalActive,
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  SizedBox(height: 25),
                  Text(
                    authController.user.value?.name ?? '',
                    style: Get.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    authController.user.value?.role ?? '',
                    style: Get.textTheme.titleMedium!.copyWith(color: MainColor.greyNormal),
                  ),
                  SizedBox(height: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.profileDetail());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: SecondaryColor.neutral100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Get.size.width * 0.15,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: SvgPicture.asset(height: 24.h, IconAssets.profileCircle, color: Colors.black),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Profil Pengguna",
                                    style: Get.textTheme.labelMedium!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: 10),
                      // GestureDetector(
                      //   onTap: () {
                      //     Get.toNamed(Routes.profileChangePassword());
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: SecondaryColor.neutral100,
                      //       borderRadius: BorderRadius.circular(8),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                      //       child: Row(
                      //         children: [
                      //           SizedBox(
                      //             width: Get.size.width * 0.15,
                      //             child: Align(
                      //               alignment: Alignment.centerLeft,
                      //               child: SvgPicture.asset(height: 24.h, IconAssets.lock, color: Colors.black),
                      //             ),
                      //           ),
                      //           Expanded(
                      //             child: Text(
                      //               "Ganti Password",
                      //               style: Get.textTheme.labelMedium!.copyWith(
                      //                 color: Colors.black,
                      //                 fontWeight: FontWeight.w600,
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 10),
                      if (authController.user.value?.role == 'AM' || authController.user.value?.role == 'Direksi') ...[
                        GestureDetector(
                          onTap: () {
                            BuildCustomDialog.show(
                              context: context,
                              padding: const EdgeInsets.all(25),
                              borderRadius: 16,
                              content: ConfirmationDialogContent(
                                message: "Apakah Anda yakin ingin meminta update lokasi kepada semua pengguna?",
                                trueText: "Ya",
                                falseText: "Batal",
                                isLoading: controller.isRequestingLocation,
                                onTruePressed: () {
                                  controller.requestAllLocation();
                                },
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: SecondaryColor.neutral100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.size.width * 0.15,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.share_location, size: 24.h, color: MainColor.blueNormalActive),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Request Lokasi User",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                      GestureDetector(
                        onTap: () {
                          controller.handleLogout();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: SecondaryColor.neutral100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Get.size.width * 0.15,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: SvgPicture.asset(height: 24.h, IconAssets.exit, color: Colors.red),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Keluar",
                                    style: Get.textTheme.labelMedium!.copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
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
        bottomNavigationBar: BuildBottomNavigationBar(),
      );
    });
  }
}
