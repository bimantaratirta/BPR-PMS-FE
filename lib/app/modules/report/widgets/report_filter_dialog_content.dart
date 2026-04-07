import 'package:bpr_pms/app/widgets/build_custom_dropdown.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:bpr_pms/app/common/constant/app_colors.dart';

class ReportFilterDialogContent extends StatefulWidget {
  final String? initialStatus;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;

  final Function(String?, DateTime?, DateTime?) onApply;
  final VoidCallback onReset;

  const ReportFilterDialogContent({
    super.key,
    this.initialStatus,
    this.initialStartDate,
    this.initialEndDate,
    required this.onApply,
    required this.onReset,
  });

  @override
  State<ReportFilterDialogContent> createState() => _ReportFilterDialogContentState();
}

class _ReportFilterDialogContentState extends State<ReportFilterDialogContent> {
  late String _tempStatus;
  final List<Map<String, String>> _statusItems = [
    {'value': 'GOOD', 'label': 'Good'},
    {'value': 'BAD', 'label': 'Bad'},
  ];

  DateTime? _tempStartDate;
  DateTime? _tempEndDate;

  final DateFormat _dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');

  @override
  void initState() {
    super.initState();
    _tempStatus = widget.initialStatus ?? "";
    _tempStartDate = widget.initialStartDate;
    _tempEndDate = widget.initialEndDate;
  }

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: (isStartDate ? _tempStartDate : _tempEndDate) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _tempStartDate = picked;
        } else {
          _tempEndDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Filter Laporan",
            style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600, fontSize: 16.sp),
          ),
        ),
        SizedBox(height: 12.h),
        Text("Status", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
        SizedBox(height: 8.h),
        BuildDropdown(
          selectedValue: _tempStatus,
          selectedLabel: _statusItems.firstWhere(
            (item) => item['value'] == _tempStatus,
            orElse: () => _statusItems.first,
          )['label']!,
          hintText: "Pilih Status",
          itemDropdown: _statusItems,
          onChanged: (String? newValue) {
            setState(() {
              _tempStatus = newValue ?? "";
            });
          },
          buttonBorderColor: SecondaryColor.neutral400,
          buttonBorderWidth: 1.5,
          buttonBackgroundColor: SecondaryColor.white,
        ),

        SizedBox(height: 16.h),
        Text("Tanggal Dibuat", style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)),
        SizedBox(height: 8.h),

        _buildDatePickerButton(
          context: context,
          label: "Dari Tanggal:",
          date: _tempStartDate,
          onPressed: () => _pickDate(context, true),
        ),

        SizedBox(height: 8.h),

        _buildDatePickerButton(
          context: context,
          label: "Sampai Tanggal:",
          date: _tempEndDate,
          onPressed: () => _pickDate(context, false),
        ),

        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SecondaryColor.danger600,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                  minimumSize: Size(100.w, 48.h),
                ),
                onPressed: widget.onReset,
                child: Text(
                  "Reset",
                  style: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MainColor.blue5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                  minimumSize: Size(100.w, 48.h),
                ),
                onPressed: () {
                  final bool isDateRangeValid = (_tempStartDate == null) == (_tempEndDate == null);

                  if (isDateRangeValid) {
                    widget.onApply(_tempStatus.isEmpty ? null : _tempStatus, _tempStartDate, _tempEndDate);
                  } else {
                    CustomSnackbar(message: "Rentang Tanggal Tidak Valid.", type: CustomSnackbarType.warning).show(context);
                  }
                },
                child: Text(
                  "Terapkan",
                  style: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              minimumSize: Size(100.w, 48.h),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              "Batal",
              style: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePickerButton({
    required BuildContext context,
    required String label,
    required DateTime? date,
    required VoidCallback onPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500)),
        SizedBox(height: 4.h),
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 16.h),
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: SecondaryColor.neutral400),
                  ),
                ),
                onPressed: onPressed,
                child: Text(
                  date == null ? "Pilih Tanggal" : _dateFormat.format(date),
                  style: Get.textTheme.bodyMedium!.copyWith(
                    color: date == null ? SecondaryColor.neutral500 : MainColor.blueLight3,
                    fontWeight: date != null ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
