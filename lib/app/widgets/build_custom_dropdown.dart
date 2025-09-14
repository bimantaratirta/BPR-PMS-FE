import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuildDropdown extends StatelessWidget {
  final String selectedValue;
  final String selectedLabel;
  final String hintText;
  final List<Map<String, String>> itemDropdown;
  final void Function(String?)? onChanged;

  const BuildDropdown({
    super.key,
    required this.selectedValue,
    required this.selectedLabel,
    required this.itemDropdown,
    required this.onChanged,
    this.hintText = "Select item",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          value: selectedValue.isNotEmpty ? selectedValue : null,
          hint: Text(
            hintText,
            style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal, color: MainColor.blueNormal),
          ),
          items: itemDropdown
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item['value'],
                  child: Text(
                    item['label'] ?? '',
                    style: Get.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: SecondaryColor.blackCharcoal,
                    ),
                  ),
                ),
              )
              .toList(),
          selectedItemBuilder: (context) {
            return itemDropdown.map((item) {
              return Center(
                child: Text(
                  item['label'] ?? '',
                  style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.normal, color: MainColor.blueNormal),
                ),
              );
            }).toList();
          },
          onChanged: onChanged,
          buttonStyleData: ButtonStyleData(
            width: 250.w,
            height: 40.h,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: MainColor.blueLight,
              border: Border.all(color: SecondaryColor.neutral400, width: 0),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down_rounded, size: 30),
            iconEnabledColor: MainColor.blueNormal,
          ),
          dropdownStyleData: DropdownStyleData(
            elevation: 0,
            offset: Offset(0, -8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: SecondaryColor.white,
              border: Border.all(color: SecondaryColor.neutral400),
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            height: 35.h,
            overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.pressed)) {
                return MainColor.greenLightHover;
              }
              return null;
            }),
          ),
        ),
      ),
    );
  }
}
