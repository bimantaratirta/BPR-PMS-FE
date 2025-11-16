import 'dart:math';

import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/data/modules/region/models/region_model.dart';
import 'package:bpr_pms/app/widgets/build_custom_dropdown.dart';
import 'package:bpr_pms/app/widgets/build_dynamic_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bpr_pms/app/modules/office/_office_detail/widgets/branch_card.dart';
import 'package:get/get.dart';

import '../controllers/office_office_detail_controller.dart';

class OfficeOfficeDetailView extends GetView<OfficeOfficeDetailController> {
  const OfficeOfficeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final double headerHeight = Get.height * 0.28;
    final double contentOverlap = 20.0;

    return Obx(() {
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
                          'Kantor ${controller.regionData.value?.region ?? 'Unknown'}',
                          style: Get.textTheme.headlineSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${controller.userAmData.value?.name ?? 'Unknown'} | AM',
                          style: Get.textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${controller.regionData.value?.branchCount ?? '-'} Kantor kas',
                          style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white),
                        ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SLO',
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

                      controller.isLoading.isTrue
                          ? Center(child: CircularProgressIndicator())
                          : controller.dashboardAmData.value == null
                          ? Center(
                              child: Text(
                                'Data tidak tersedia',
                                style: Get.textTheme.bodyMedium!.copyWith(color: Colors.black54),
                              ),
                            )
                          : Obx(() {
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
                            }),

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
                                      "${controller.totalWeekPercentageChange.value >= 0 ? '+' : ''}${controller.totalWeekPercentageChange.value.toStringAsFixed(2)}%",
                                      style: Get.textTheme.labelLarge!.copyWith(
                                        color: controller.totalWeekPercentageChange.value >= 0 ? Colors.green : Colors.red,
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
                                      "${controller.totalMonthPercentageChange.value >= 0 ? '+' : ''}${controller.totalMonthPercentageChange.value.toStringAsFixed(2)}%",
                                      style: Get.textTheme.labelLarge!.copyWith(
                                        color: controller.totalMonthPercentageChange.value >= 0 ? Colors.green : Colors.red,
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

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.h),
                        child: Divider(color: SecondaryColor.neutral300),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'List Kantor Kas',
                            style: Get.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.showCreateOfficeBranchDialog(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 4)),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: SvgPicture.asset(
                                          height: 18.h,
                                          IconAssets.plus,
                                          color: SecondaryColor.neutral500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Tambah",
                                      style: Get.textTheme.labelMedium!.copyWith(
                                        color: SecondaryColor.neutral500,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),

                      ...List.generate(controller.regionData.value?.branches?.length ?? 0, (index) {
                        final Branch data = controller.regionData.value?.branches?[index] as Branch;

                        return Column(
                          children: [
                            BranchCard(branchData: data),
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
    });
  }
}
