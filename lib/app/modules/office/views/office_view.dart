import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/modules/main/controllers/main_controller.dart';
import 'package:bpr_pms/app/modules/office/widgets/office_card.dart';
import 'package:bpr_pms/app/widgets/build_navigation/build_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/office_controller.dart';

class OfficeView extends GetView<OfficeController> {
  const OfficeView({super.key});
  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find<MainController>();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'List Kantor',
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
              icon: SvgPicture.asset(height: 16.h, IconAssets.chevronLeft, color: MainColor.blue5),
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
            Expanded(
              child: controller.isLoading.isTrue
                  ? Center(child: CircularProgressIndicator())
                  : controller.regionsData.value.isEmpty
                  ? RefreshIndicator(
                      onRefresh: () => controller.refreshData(context),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: Get.size.height - kToolbarHeight - Get.size.height * 0.3),
                          child: Center(
                            child: Text(
                              "Data Kantor Kosong",
                              style: Get.textTheme.bodyMedium!.copyWith(color: SecondaryColor.neutral500),
                            ),
                          ),
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => controller.refreshData(context),
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 90),
                        itemCount: controller.regionsData.value.length,
                        itemBuilder: (context, index) {
                          if (index == controller.regionsData.value.length) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 32.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final data = controller.regionsData.value[index];

                          return Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                            child: Column(children: [OfficeCard(regionData: data)]),
                          );
                        },
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
