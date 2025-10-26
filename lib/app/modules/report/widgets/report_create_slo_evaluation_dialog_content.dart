import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ReportCreateSloEvaluationDialogContent extends StatelessWidget {
  final VoidCallback? onTruePressed;
  final RxBool? isLoading;

  const ReportCreateSloEvaluationDialogContent({super.key, this.onTruePressed, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 40.w),
          child: Center(child: SvgPicture.asset(IconAssets.writePaper, height: 45.h)),
        ),
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MainColor.blue5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                  minimumSize: Size(100.w, 48.h),
                ),
                onPressed: (isLoading?.value ?? false) ? null : (onTruePressed ?? () => Get.back()),
                child: Text(
                  "Buat Penilaian",
                  style: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
