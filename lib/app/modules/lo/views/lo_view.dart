import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/modules/lo/widgets/lo_card.dart';
import 'package:bpr_pms/app/modules/main/controllers/main_controller.dart';
import 'package:bpr_pms/app/widgets/build_navigation/build_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/lo_controller.dart';

class LoView extends GetView<LoController> {
  const LoView({super.key});
  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find<MainController>();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'List LO',
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
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
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
                                  hintText: "Cari LO...",
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
                ],
              ),
            ),
            SizedBox(height: Get.size.height * 0.02),
            Expanded(
              child: controller.isLoading.isTrue
                  ? Center(child: CircularProgressIndicator())
                  : controller.usersLoData.value.isEmpty
                  ? RefreshIndicator(
                      onRefresh: () => controller.refreshData(context),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: Get.size.height - kToolbarHeight - Get.size.height * 0.3),
                          child: Center(
                            child: Text(
                              "Data Laporan Kosong",
                              style: Get.textTheme.bodyMedium!.copyWith(color: SecondaryColor.neutral500),
                            ),
                          ),
                        ),
                      ),
                    )
                  : NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                            controller.hasMoreData.value &&
                            !controller.isPagingLoading.value) {
                          controller.getAllLoBySlo(context);
                          return true;
                        }
                        return false;
                      },
                      child: RefreshIndicator(
                        onRefresh: () => controller.refreshData(context),
                        child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 90),
                          itemCount: controller.usersLoData.value.length + (controller.isPagingLoading.value ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == controller.usersLoData.value.length) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 32.0),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }

                            final data = controller.usersLoData.value[index];

                            return Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                              child: Column(
                                children: [
                                  LoCard(userData: data),

                                  index == controller.usersLoData.value.length - 1 && controller.hasMoreData.isFalse
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
