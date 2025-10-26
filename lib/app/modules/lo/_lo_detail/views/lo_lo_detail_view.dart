import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/modules/lo/controllers/lo_controller.dart';
import 'package:bpr_pms/app/modules/nasabah/widgets/nasabah_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/lo_lo_detail_controller.dart';

class LoLoDetailView extends GetView<LoLoDetailController> {
  const LoLoDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final LoController loController = Get.find<LoController>();

    final String? itemId = Get.parameters['id'];

    if (itemId != null && controller.id.value != itemId) {
      controller.id.value = itemId;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        controller.userData.value = await controller.getUserById(Get.context!, itemId);
        await controller.getAllCustomerByLo(Get.context!, itemId, isInitialLoad: true);
      });
    }

    return Obx(() {
      return Scaffold(
        backgroundColor: MainColor.blue4,
        appBar: AppBar(
          title: Text(
            'Detail LO',
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
                loController.refreshData(Get.context!);
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
                  style: Get.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  controller.userData.value?.role ?? 'Unknown',
                  style: Get.textTheme.titleMedium!.copyWith(color: Colors.white70),
                ),
                SizedBox(height: Get.height * 0.02),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20.h),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: controller.isLoading.isTrue
                    ? Center(child: CircularProgressIndicator())
                    : controller.customersData.value.isEmpty
                    ? RefreshIndicator(
                        onRefresh: () => controller.refreshData(context),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: Get.size.height - kToolbarHeight - Get.size.height * 0.3),
                            child: Center(
                              child: Text(
                                "Data Nasabah Kosong",
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
                            controller.getAllCustomerByLo(context, controller.id.value);
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
                                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 15.h),
                                child: Column(
                                  children: [
                                    NasabahCard(customerData: data),

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
            ),
          ],
        ),
      );
    });
  }
}
