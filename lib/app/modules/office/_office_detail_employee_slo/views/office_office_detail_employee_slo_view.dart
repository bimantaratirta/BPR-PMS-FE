import 'dart:math';

import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/modules/office/_office_detail_employee/controllers/office_office_detail_employee_controller.dart';
import 'package:bpr_pms/app/modules/office/widgets/employee_card.dart';
import 'package:bpr_pms/app/widgets/build_custom_dropdown.dart';
import 'package:bpr_pms/app/widgets/build_dynamic_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/office_office_detail_employee_slo_controller.dart';

class OfficeOfficeDetailEmployeeSloView extends GetView<OfficeOfficeDetailEmployeeSloController> {
  const OfficeOfficeDetailEmployeeSloView({super.key});
  @override
  Widget build(BuildContext context) {
    final OfficeOfficeDetailEmployeeController officeEmployeeController = Get.find<OfficeOfficeDetailEmployeeController>();

    return Obx(() {
      return Scaffold(
        backgroundColor: MainColor.blueLight1,
        appBar: AppBar(
          title: Text(
            'Detail SLO',
            style: Get.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0.0,
          forceMaterialTransparency: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: IconButton(
              icon: SvgPicture.asset(height: 16.h, IconAssets.chevronLeft, color: Colors.black),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
                officeEmployeeController.refreshData(Get.context!);
              },
            ),
          ),
          titleSpacing: 4,
        ),
        body: Column(
          children: [
            Column(
              children: [
                SizedBox(height: Get.height * 0.02),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 60, color: MainColor.blue4),
                ),
                SizedBox(height: Get.height * 0.02),
                Text(
                  controller.userData.value?.name ?? 'Unknown',
                  style: Get.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600, color: Colors.black),
                ),
                SizedBox(height: 5),
                Text(
                  controller.userData.value?.role ?? 'Unknown',
                  style: Get.textTheme.titleMedium!.copyWith(color: Colors.black54),
                ),
                SizedBox(height: Get.height * 0.02),
              ],
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                        controller.hasMoreData.value &&
                        !controller.isPagingLoading.value) {
                      controller.getAllLoBySlo(context, controller.id.value);
                      return true;
                    }
                    return false;
                  },
                  child: RefreshIndicator(
                    onRefresh: () => controller.refreshData(context),
                    child: SingleChildScrollView(
                      child: controller.isLoading.isTrue
                          ? ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: Get.size.height - kToolbarHeight - Get.size.height * 0.3,
                              ),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : Padding(
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
                                            'LO',
                                            style: Get.textTheme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: MainColor.greyLightActive,
                                            ),
                                          ),
                                          Text(
                                            'Rata - Rata Nasabah',
                                            style: Get.textTheme.titleMedium!.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                                      : controller.dashboardSloData.value == null
                                      ? Center(
                                          child: Text(
                                            'Data tidak tersedia',
                                            style: Get.textTheme.bodyMedium!.copyWith(color: Colors.black54),
                                          ),
                                        )
                                      : Obx(() {
                                          final int maxValueLoNasabahInt = controller.loNasabahChartData.isEmpty
                                              ? 0
                                              : controller.loNasabahChartData
                                                    .map((item) => item['value'] as int)
                                                    .reduce(max);

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
                                                  "${controller.totalMonthPercentageChange.value >= 0 ? '+' : ''}${controller.totalMonthPercentageChange.value.toStringAsFixed(2)}%",
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

                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                                    child: Divider(color: SecondaryColor.neutral300),
                                  ),

                                  Text(
                                    'List LO',
                                    style: Get.textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 14.h),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.2),
                                                blurRadius: 10,
                                                offset: Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: Get.size.width * 0.1,
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: SvgPicture.asset(
                                                      height: 18.h,
                                                      IconAssets.search,
                                                      color: SecondaryColor.neutral500,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                    controller: controller.searchController,
                                                    decoration: InputDecoration(
                                                      hintText: "Cari LO...",
                                                      hintStyle: Get.textTheme.labelMedium!.copyWith(
                                                        color: SecondaryColor.neutral500,
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
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 14.h),

                                  ...(controller.usersLoData.value.isEmpty
                                      ? [
                                          Center(
                                            child: Text(
                                              "Data Lo Kosong",
                                              style: Get.textTheme.bodyMedium!.copyWith(color: SecondaryColor.neutral500),
                                            ),
                                          ),
                                        ]
                                      : List.generate(controller.usersLoData.value.length, (index) {
                                          final data = controller.usersLoData.value[index];

                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 15.h),
                                            child: Column(
                                              children: [
                                                EmployeeCard(userData: data),

                                                index == controller.usersLoData.value.length - 1 &&
                                                        controller.hasMoreData.isFalse
                                                    ? Align(
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
                                                          child: SizedBox(
                                                            child: Text(
                                                              "Anda telah mencapai akhir data",
                                                              style: Get.textTheme.labelMedium!.copyWith(
                                                                color: SecondaryColor.neutral500,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox.shrink(),
                                              ],
                                            ),
                                          );
                                        })),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
