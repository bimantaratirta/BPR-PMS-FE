import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/modules/nasabah/_nasabah_detail/bindings/nasabah_nasabah_detail_binding.dart';
import 'package:bpr_pms/app/modules/nasabah/_nasabah_detail/views/nasabah_nasabah_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/lo_lo_detail_controller.dart';

class LoLoDetailView extends GetView<LoLoDetailController> {
  const LoLoDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.blueNormal,
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
              CircleAvatar(radius: 50, backgroundImage: NetworkImage('https://placehold.co/150')),
              SizedBox(height: Get.height * 0.02),
              Text(
                'John Doe',
                style: Get.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
              ),
              SizedBox(height: 5),
              Text('LO', style: Get.textTheme.titleMedium!.copyWith(color: Colors.white70)),
              SizedBox(height: Get.height * 0.02),
            ],
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => NasabahNasabahDetailView(), binding: NasabahNasabahDetailBinding());
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(color: MainColor.blueLight, borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(18),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: Get.size.height * 0.08,
                                    width: Get.size.height * 0.08,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage('https://placehold.co/150'),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Lorem Ipsum',
                                          style: Get.textTheme.titleMedium!.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '08123123123',
                                          style: Get.textTheme.bodyMedium!.copyWith(color: Colors.black54),
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                ],
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
          ),
        ],
      ),
    );
  }
}
