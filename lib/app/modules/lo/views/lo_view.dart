import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
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
              mainController.changePage(HOME_INDEX);
            },
          ),
        ),
        titleSpacing: 4,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 25),
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Get.size.height * 0.02),
                Row(
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
                SizedBox(height: Get.size.height * 0.02),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: MainColor.blueNormal,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 4))],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        SizedBox(
                          height: Get.size.height * 0.08,
                          width: Get.size.height * 0.08,
                          child: CircleAvatar(radius: 50, backgroundImage: NetworkImage('https://placehold.co/150')),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Doe',
                                style: Get.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                              SizedBox(height: 4),
                              Text('LO', style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white70)),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BuildBottomNavigationBar(),
    );
  }
}
