import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/modules/main/controllers/main_controller.dart';
import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:bpr_pms/app/widgets/build_navigation/build_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/nasabah_controller.dart';

class NasabahView extends GetView<NasabahController> {
  const NasabahView({super.key});
  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find<MainController>();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'List Nasabah',
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
              icon: SvgPicture.asset(height: 16.h, IconAssets.chevronLeft, color: MainColor.blueNormal),
              onPressed: () {
                mainController.navigateToHome();
              },
            ),
          ),
          titleSpacing: 4,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Get.size.height * 0.02),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 4))],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.size.width * 0.1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(height: 18.h, IconAssets.search, color: SecondaryColor.neutral500),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: controller.searchController,
                                decoration: InputDecoration(
                                  hintText: "Cari Nasabah...",
                                  hintStyle: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.neutral500),
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
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.nasabahCreate());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 4))],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        child: Row(
                          children: [
                            SizedBox(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SvgPicture.asset(height: 18.h, IconAssets.plus, color: SecondaryColor.neutral500),
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
            ),
            SizedBox(height: Get.size.height * 0.02),
            Expanded(
              child: controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : controller.customersData.value.isEmpty
                  ? Center(
                      child: Text(
                        "Data Nasabah Kosong",
                        style: Get.textTheme.bodyMedium!.copyWith(color: SecondaryColor.neutral500),
                      ),
                    )
                  : NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                            controller.hasMoreData.value &&
                            !controller.isPagingLoading.value) {
                          controller.getAllCustomer(context);
                          return true;
                        }
                        return false;
                      },
                      child: RefreshIndicator(
                        onRefresh: () => controller.refreshData(context),
                        child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 90),
                          itemCount: controller.customersData.value.length + (controller.isPagingLoading.value ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == controller.customersData.value.length) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 32.0),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }

                            final data = controller.customersData.value[index];

                            return Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
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
                                      padding: const EdgeInsets.all(24),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.name ?? "-",
                                            style: Get.textTheme.titleMedium!.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: MainColor.blueLight,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        "No Handphone",
                                                        style: Get.textTheme.bodyMedium!.copyWith(
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        data.phoneNumber ?? "-",
                                                        style: Get.textTheme.bodyMedium!.copyWith(
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(color: SecondaryColor.neutral300, height: 1),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        "RT/RW",
                                                        style: Get.textTheme.bodyMedium!.copyWith(
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        data.rtRw ?? "-",
                                                        style: Get.textTheme.bodyMedium!.copyWith(
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(Routes.nasabahDetail(data.id ?? ""));
                                            },
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                child: SizedBox(
                                                  child: Text(
                                                    "Detail",
                                                    style: Get.textTheme.labelMedium!.copyWith(
                                                      color: MainColor.blueNormal,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  index == controller.customersData.value.length - 1 && controller.hasMoreData.isFalse
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
                          },
                        ),
                      ),
                    ),
            ),
          ],
        ),
        bottomNavigationBar: BuildBottomNavigationBar(),
      );
    });
  }
}
