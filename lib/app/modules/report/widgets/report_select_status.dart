import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class _StatusOption extends StatelessWidget {
  final String label;
  final bool value;
  final VoidCallback onTap;
  final bool isSelected;
  final Color? trueColor;
  final Color? falseColor;

  const _StatusOption({
    required this.label,
    required this.value,
    required this.onTap,
    required this.isSelected,
    this.trueColor,
    this.falseColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: isSelected
                  ? (value ? (trueColor ?? MainColor.blueNormal) : (falseColor ?? MainColor.blueNormal))
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: SecondaryColor.neutral300, width: 2),
            ),
            child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: Get.textTheme.labelMedium!.copyWith(
              color: isSelected ? SecondaryColor.neutral600 : SecondaryColor.neutral500,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class ReportSelectStatus extends StatelessWidget {
  final String? trueLabel;
  final String? falseLabel;
  final Color? trueColor;
  final Color? falseColor;
  final Function(bool) onSelect;
  final Rx<bool?> selectedStatus;

  const ReportSelectStatus({
    super.key,
    this.trueLabel,
    this.falseLabel,
    required this.onSelect,
    required this.selectedStatus,
    this.trueColor,
    this.falseColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 12, bottom: 12),
      child: Obx(() {
        final currentStatus = selectedStatus.value;

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _StatusOption(
              label: falseLabel ?? "Tidak Sesuai",
              value: false,
              onTap: () => onSelect(false),
              isSelected: currentStatus == false,
              trueColor: trueColor,
              falseColor: falseColor,
            ),

            SizedBox(width: 28.w),

            _StatusOption(
              label: trueLabel ?? "Sesuai",
              value: true,
              onTap: () => onSelect(true),
              isSelected: currentStatus == true,
              trueColor: trueColor,
              falseColor: falseColor,
            ),
          ],
        );
      }),
    );
  }
}
