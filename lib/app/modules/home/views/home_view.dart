import 'dart:math';

import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:bpr_pms/app/widgets/build_custom_dropdown.dart';
import 'package:bpr_pms/app/widgets/build_dynamic_progress_bar.dart';
import 'package:bpr_pms/app/widgets/build_navigation/build_bottom_navigation_bar.dart';
import 'package:bpr_pms/app/widgets/chart/lo_nasabah_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    Widget buildBlueHeader() {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [MainColor.blue1, MainColor.blue2],
            stops: [0.0, 1.0],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -140.h,
              right: -260.w,
              child: Container(
                width: 400.w,
                height: 400.w,
                decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(999.r)),
              ),
            ),

            Positioned(
              bottom: -280.h,
              left: -190.w,
              child: Container(
                width: 450.w,
                height: 450.w,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.1), borderRadius: BorderRadius.circular(999.r)),
              ),
            ),

            Positioned(
              bottom: -470.h,
              right: -470.w,
              child: Container(
                width: 600.w,
                height: 600.w,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.1), borderRadius: BorderRadius.circular(999.r)),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 25.h, top: 40.h, left: 20.w, right: 20.w),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Image.asset(ImageAssets.logoBprSahabatSejatiTransparant, scale: 1),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BPR Sahabat Sejati',
                              style: Get.textTheme.titleLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Program Management System',
                              style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: MainColor.blue3,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, size: 40, color: MainColor.blueNormalActive),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                authController.user.value?.name ?? '-',
                                style: Get.textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                authController.user.value?.role ?? '-',
                                style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white70),
                              ),
                              authController.pickRole.value != UserRole.am &&
                                      authController.pickRole.value != UserRole.direksi
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Divider(color: Colors.white30, height: 20),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    authController.pickRole.value == UserRole.lo
                                                        ? "SLO"
                                                        : authController.pickRole.value == UserRole.slo
                                                        ? "AM"
                                                        : "-",
                                                    style: Get.textTheme.bodyMedium!.copyWith(
                                                      color: Colors.white70,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    authController.user.value?.supervisor?.name ?? '-',
                                                    style: Get.textTheme.bodyMedium!.copyWith(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(width: 1, height: 30, color: Colors.white30),
                                            SizedBox(width: 15),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Kantor',
                                                    style: Get.textTheme.bodyMedium!.copyWith(
                                                      color: Colors.white70,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    authController.user.value?.branch?.branch ?? '-',
                                                    style: Get.textTheme.bodyMedium!.copyWith(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget buildWhiteContent() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), offset: const Offset(0, -10), blurRadius: 20.0)],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          authController.pickRole.value == UserRole.lo
                              ? 'Nasabah'
                              : authController.pickRole.value == UserRole.slo
                              ? 'LO'
                              : authController.pickRole.value == UserRole.am
                              ? 'SLO'
                              : authController.pickRole.value == UserRole.direksi
                              ? 'Direksi'
                              : '-',
                          style: Get.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: MainColor.greyLightActive,
                          ),
                        ),
                        Text(
                          'Rata - Rata Nasabah',
                          style: Get.textTheme.titleMedium!.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: BuildDropdown(
                          hintText: "Filter nasabah...",
                          selectedValue: controller.selectedLoNasabahDisplayFilter.value,
                          selectedLabel:
                              controller.itemsSelectLoNasabahDisplayFilter.value.firstWhereOrNull(
                                (item) => item["value"] == controller.selectedLoNasabahDisplayFilter.value,
                              )?["label"] ??
                              '',
                          itemDropdown: controller.itemsSelectLoNasabahDisplayFilter.value,
                          onChanged: (value) => {
                            if (value != null) {controller.changeSelectedLoNasabahDisplayFilter(value)},
                          },
                          buttonWidth: 100.w,
                          buttonBorderRadius: 99,
                          buttonBackgroundColor: SecondaryColor.neutral100,
                          buttonTextColor: Colors.black,
                          buttonFocusedBorderColor: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.h),
                  child: Divider(color: SecondaryColor.neutral300),
                ),
                controller.isLoading.value
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50.h),
                          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(MainColor.blue5)),
                        ),
                      )
                    : Column(
                        children: [
                          authController.pickRole.value == UserRole.lo
                              ? Column(
                                  children: [
                                    LoNasabahChart(
                                      type: controller.selectedLoNasabahDisplayFilter.value == 'minggu'
                                          ? ChartType.weekly
                                          : ChartType.monthly,
                                      values: controller.dashboardLoData.value?.customers ?? [],
                                    ),
                                  ],
                                )
                              : authController.pickRole.value == UserRole.slo
                              ? Obx(() {
                                  final int maxValueLoNasabahInt = controller.loNasabahChartData.isEmpty
                                      ? 0
                                      : controller.loNasabahChartData.map((item) => item['value'] as int).reduce(max);

                                  return Column(
                                    children: [
                                      ...controller.loNasabahChartData.map((item) {
                                        final String label = item['label'] as String;
                                        final int value = item['value'] as int;
                                        final dynamic barColor;

                                        if (value == maxValueLoNasabahInt && value != 0) {
                                          barColor = LinearGradient(
                                            colors: [MainColor.blue2, MainColor.blue3],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          );
                                        } else {
                                          barColor = Color(0xFF8A8A8A);
                                        }

                                        return BuildDynamicProgressBar(
                                          label: label,
                                          value: value,
                                          maxValue: maxValueLoNasabahInt.toDouble(),
                                          barColor: barColor,
                                        );
                                      }).toList(),
                                    ],
                                  );
                                })
                              : authController.pickRole.value == UserRole.am
                              ? Obx(() {
                                  final int maxValueSloNasabahInt = controller.sloNasabahChartData.isEmpty
                                      ? 0
                                      : controller.sloNasabahChartData.map((item) => item['value'] as int).reduce(max);

                                  return Column(
                                    children: [
                                      ...controller.sloNasabahChartData.map((item) {
                                        final String label = item['label'] as String;
                                        final int value = item['value'] as int;
                                        final dynamic barColor;

                                        if (value == maxValueSloNasabahInt && value != 0) {
                                          barColor = LinearGradient(
                                            colors: [MainColor.blue2, MainColor.blue3],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          );
                                        } else {
                                          barColor = Color(0xFF8A8A8A);
                                        }

                                        return BuildDynamicProgressBar(
                                          label: label,
                                          value: value,
                                          maxValue: maxValueSloNasabahInt.toDouble(),
                                          barColor: barColor,
                                        );
                                      }).toList(),
                                    ],
                                  );
                                })
                              : authController.pickRole.value == UserRole.direksi
                              ? Obx(() {
                                  final int maxValueRegionNasabahInt = controller.regionNasabahChartData.isEmpty
                                      ? 0
                                      : controller.regionNasabahChartData.map((item) => item['value'] as int).reduce(max);

                                  return Column(
                                    children: [
                                      ...controller.regionNasabahChartData.map((item) {
                                        final String label = item['label'] as String;
                                        final int value = item['value'] as int;
                                        final dynamic barColor;

                                        if (value == maxValueRegionNasabahInt && value != 0) {
                                          barColor = LinearGradient(
                                            colors: [MainColor.blue2, MainColor.blue3],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          );
                                        } else {
                                          barColor = Color(0xFF8A8A8A);
                                        }

                                        return BuildDynamicProgressBar(
                                          label: label,
                                          value: value,
                                          maxValue: maxValueRegionNasabahInt.toDouble(),
                                          barColor: barColor,
                                        );
                                      }).toList(),
                                    ],
                                  );
                                })
                              : SizedBox.shrink(),

                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0.h),
                            child: Divider(color: SecondaryColor.neutral300),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 8.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Minggu Ini',
                                      style: Get.textTheme.titleMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      children: [
                                        Text(
                                          controller.totalWeekCurrentPeriod.value.toString(),
                                          style: Get.textTheme.titleLarge!.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          "Orang",
                                          style: Get.textTheme.titleSmall!.copyWith(
                                            color: SecondaryColor.neutral500,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      children: [
                                        controller.totalWeekPercentageChange.value >= 0
                                            ? Icon(Icons.arrow_circle_up, color: Colors.green, size: 24.sp)
                                            : Icon(Icons.arrow_circle_down, color: Colors.red, size: 24.sp),
                                        SizedBox(width: 3.w),
                                        Text(
                                          "${controller.totalWeekPercentageChange.value >= 0 ? '+' : '-'}${controller.totalWeekPercentageChange.value.toStringAsFixed(2)}%",
                                          style: Get.textTheme.labelLarge!.copyWith(
                                            color: controller.totalWeekPercentageChange.value >= 0
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Bulan Ini',
                                      style: Get.textTheme.titleMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      children: [
                                        Text(
                                          controller.totalMonthCurrentPeriod.value.toString(),
                                          style: Get.textTheme.titleLarge!.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          "Orang",
                                          style: Get.textTheme.titleSmall!.copyWith(
                                            color: SecondaryColor.neutral500,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      children: [
                                        controller.totalMonthPercentageChange.value >= 0
                                            ? Icon(Icons.arrow_circle_up, color: Colors.green, size: 24.sp)
                                            : Icon(Icons.arrow_circle_down, color: Colors.red, size: 24.sp),
                                        SizedBox(width: 3.w),
                                        Text(
                                          "${controller.totalMonthPercentageChange.value >= 0 ? '+' : '-'}${controller.totalMonthPercentageChange.value.toStringAsFixed(2)}%",
                                          style: Get.textTheme.labelLarge!.copyWith(
                                            color: controller.totalMonthPercentageChange.value >= 0
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),
                        ],
                      ),

                // Align(
                //   alignment: Alignment.center,
                //   child: SizedBox(
                //     width: Get.size.width * 0.5,
                //     child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: MainColor.blue5,
                //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                //         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                //       ),
                //       onPressed: () {},
                //       child: Text(
                //         "Detail",
                //         style: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.white, fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
    }

    return Obx(() {
      return Scaffold(
        backgroundColor: MainColor.blueNormalActive,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[SliverToBoxAdapter(child: buildBlueHeader())];
            },
            body: buildWhiteContent(),
          ),
        ),
        bottomNavigationBar: BuildBottomNavigationBar(),
      );
    });
  }
}
