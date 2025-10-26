import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/office_office_detail_controller.dart';

class OfficeOfficeDetailView extends GetView<OfficeOfficeDetailController> {
  const OfficeOfficeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final double headerHeight = Get.height * 0.28;
    final double contentOverlap = 20.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: headerHeight,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(ImageAssets.officeBackground), fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [MainColor.grey1, MainColor.greyLight1.withOpacity(0.1)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: contentOverlap),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Kantor Selatan',
                        style: Get.textTheme.headlineSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 2.h),
                      Text('5 Kantor kas', style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: headerHeight - contentOverlap,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        'List Kantor Kas',
                        style: Get.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    ...List.generate(6, (index) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(color: MainColor.blue4, borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(14.w),
                                  decoration: BoxDecoration(color: MainColor.blue6, borderRadius: BorderRadius.circular(8)),
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(IconAssets.office2, height: 48.h, color: Colors.white),
                                ),
                                SizedBox(width: 14.w),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Kantor Kas A',
                                        style: Get.textTheme.bodyLarge!.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Jl. Merdeka No.123, Jakarta',
                                        style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.h),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 24.h,
            left: 12.w,
            child: IconButton(
              icon: SvgPicture.asset(IconAssets.chevronLeft, height: 16.h, color: MainColor.blue5),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          Positioned(
            top: 24.h + 12.h,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'List Kantor Kas',
                style: Get.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
