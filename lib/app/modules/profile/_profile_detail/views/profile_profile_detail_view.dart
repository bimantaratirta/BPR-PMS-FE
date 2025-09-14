import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/profile_profile_detail_controller.dart';

class ProfileProfileDetailView extends GetView<ProfileProfileDetailController> {
  const ProfileProfileDetailView({super.key});
  @override
  Widget build(BuildContext context) {
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
      body: const Center(child: Text('ProfileProfileDetailView is working', style: TextStyle(fontSize: 20))),
    );
  }
}
