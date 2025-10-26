import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/data/modules/region/models/region_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BranchCard extends StatelessWidget {
  final Branch branchData;

  const BranchCard({super.key, required this.branchData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(Routes.officeDetail(branchData.id ?? ''));
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(color: MainColor.blue4, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(color: MainColor.blue6, borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: SvgPicture.asset(IconAssets.office2, height: 48.h, color: Colors.white),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    branchData.branch ?? 'Unknown',
                    style: Get.textTheme.bodyLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  Text(branchData.address ?? 'Unknown', style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
