import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/modules/profile/_profile_change_password/bindings/profile_profile_change_password_binding.dart';
import 'package:bpr_pms/app/modules/profile/_profile_change_password/views/profile_profile_change_password_view.dart';
import 'package:bpr_pms/app/modules/profile/_profile_detail/bindings/profile_profile_detail_binding.dart';
import 'package:bpr_pms/app/modules/profile/_profile_detail/views/profile_profile_detail_view.dart';
import 'package:bpr_pms/app/widgets/build_navigation/build_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
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
                CircleAvatar(radius: 50, backgroundImage: NetworkImage('https://placehold.co/150')),
                SizedBox(height: 25),
                Text('John Doe', style: Get.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 5),
                Text('LO', style: Get.textTheme.titleMedium!.copyWith(color: MainColor.greyNormal)),
                SizedBox(height: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ProfileProfileDetailView(), binding: ProfileProfileDetailBinding());
                      },
                      child: Container(
                        decoration: BoxDecoration(color: SecondaryColor.neutral50, borderRadius: BorderRadius.circular(12)),
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
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ProfileProfileChangePasswordView(), binding: ProfileProfileChangePasswordBinding());
                      },
                      child: Container(
                        decoration: BoxDecoration(color: SecondaryColor.neutral50, borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                          child: Row(
                            children: [
                              SizedBox(
                                width: Get.size.width * 0.15,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: SvgPicture.asset(height: 24.h, IconAssets.lock, color: Colors.black),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Ganti Password",
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
                    GestureDetector(
                      onTap: () {
                        // Handle tap
                      },
                      child: Container(
                        decoration: BoxDecoration(color: SecondaryColor.neutral50, borderRadius: BorderRadius.circular(12)),
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
                                  style: Get.textTheme.labelMedium!.copyWith(color: Colors.red, fontWeight: FontWeight.w600),
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
  }
}
