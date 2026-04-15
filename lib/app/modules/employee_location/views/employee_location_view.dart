import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/modules/employee_location/models/employee_location_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/employee_location_controller.dart';

class EmployeeLocationView extends GetView<EmployeeLocationController> {
  const EmployeeLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            'Lokasi Karyawan',
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
              },
            ),
          ),
          titleSpacing: 4,
        ),
        body: Column(
          children: [
            // Map Section
            SizedBox(
              height: 280.h,
              child: Obx(() {
                // Trigger rebuild saat data berubah
                controller.employeeLocations.value;
                return FlutterMap(
                  mapController: controller.mapController,
                  options: MapOptions(initialCenter: controller.mapCenter.value, initialZoom: controller.mapZoom.value),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.bpr.pms',
                    ),
                    MarkerLayer(markers: controller.markers),
                  ],
                );
              }),
            ),

            // Button "Minta Lokasi Terbaru"
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: controller.isRequestingLocation.value
                        ? null
                        : () => controller.showRequestLocationConfirmation(context),
                    icon: controller.isRequestingLocation.value
                        ? SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.my_location, size: 20),
                    label: Text(
                      controller.isRequestingLocation.value ? 'Mengirim...' : 'Minta Lokasi Terbaru',
                      style: Get.textTheme.labelMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MainColor.blue1,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      elevation: 2,
                      disabledBackgroundColor: MainColor.blue1.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ),

            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  hintText: 'Cari nama karyawan...',
                  hintStyle: Get.textTheme.bodyMedium!.copyWith(color: SecondaryColor.neutral500),
                  prefixIcon: Icon(Icons.search, color: MainColor.blue1),
                  filled: true,
                  fillColor: SecondaryColor.neutral100,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: SecondaryColor.neutral300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: MainColor.blue1, width: 1.5),
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // Employee List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final employees = controller.employeeLocations.value;

                if (employees.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () => controller.refreshData(context),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: Get.size.height - kToolbarHeight - Get.size.height * 0.55),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_search, size: 60.sp, color: SecondaryColor.neutral400),
                              SizedBox(height: 12.h),
                              Text(
                                'Karyawan tidak ditemukan',
                                style: Get.textTheme.bodyMedium!.copyWith(color: SecondaryColor.neutral500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => controller.refreshData(context),
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                    itemCount: employees.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      final employee = employees[index];
                      return _buildEmployeeCard(employee);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeCard(EmployeeLocationModel employee) {
    final Helper helper = Helper();

    return GestureDetector(
      onTap: () => controller.focusOnEmployee(employee),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [MainColor.blue1, MainColor.blue3],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [BoxShadow(color: MainColor.blue1.withOpacity(0.25), blurRadius: 8, offset: const Offset(0, 3))],
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 22.r,
              backgroundColor: Colors.white.withOpacity(0.2),
              child: Icon(Icons.person, color: Colors.white, size: 24.sp),
            ),
            SizedBox(width: 12.w),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.user?.name ?? '-',
                    style: Get.textTheme.titleSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  // Time badge
                  SizedBox(height: 4.h),
                  if (employee.updatedAt != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time, color: Colors.white, size: 12.sp),
                          SizedBox(width: 4.w),
                          Text(
                            helper.formatDateTimeToID(employee.updatedAt, format: 'dd MMM yyyy, HH:mm'),
                            style: Get.textTheme.bodySmall!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white70, size: 14.sp),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Obx(() {
                          // Trigger rebuild saat addressCache berubah
                          controller.addressCache.length;
                          final address = controller.getAddress(employee);
                          return Text(
                            address,
                            style: Get.textTheme.bodySmall!.copyWith(color: Colors.white70),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Icon(Icons.gps_fixed, color: Colors.white60, size: 12.sp),
                      SizedBox(width: 4.w),
                      Text(
                        '${employee.latitude ?? '-'}, ${employee.longitude ?? '-'}',
                        style: Get.textTheme.bodySmall!.copyWith(color: Colors.white60, fontSize: 11.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
