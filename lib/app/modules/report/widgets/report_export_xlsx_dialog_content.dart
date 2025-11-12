import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/widgets/build_custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReportExportXlsxDialogContent extends StatefulWidget {
  final String? trueText;
  final String? falseText;
  final Function(int, int)? onTruePressed;
  final VoidCallback? onFalsePressed;
  final RxBool? isLoading;

  const ReportExportXlsxDialogContent({
    super.key,
    this.trueText,
    this.falseText,
    this.onTruePressed,
    this.onFalsePressed,
    this.isLoading,
  });

  @override
  State<ReportExportXlsxDialogContent> createState() => _ReportExportXlsxDialogContentState();
}

class _ReportExportXlsxDialogContentState extends State<ReportExportXlsxDialogContent> {
  late int _selectedYear;
  late int _selectedMonth;

  final Map<int, String> _months = {
    1: 'Januari',
    2: 'Februari',
    3: 'Maret',
    4: 'April',
    5: 'Mei',
    6: 'Juni',
    7: 'Juli',
    8: 'Agustus',
    9: 'September',
    10: 'Oktober',
    11: 'November',
    12: 'Desember',
  };

  late final List<int> _years;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final int currentYear = now.year;

    _selectedYear = currentYear;
    _selectedMonth = now.month;

    const int startYear = 2020;

    if (currentYear >= startYear) {
      final int numberOfYears = currentYear - startYear + 1;
      _years = List.generate(numberOfYears, (index) => startYear + index);
    } else {
      _years = [currentYear];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 30.w, top: 10.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Pilih Periode Laporan",
                  style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600, fontSize: 16.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 25.h),

              BuildDropdown(
                selectedValue: _selectedYear.toString(),
                selectedLabel: _selectedYear.toString(),
                hintText: "Pilih Tahun",

                itemDropdown: _years.map((int year) {
                  final String yearStr = year.toString();
                  return {'value': yearStr, 'label': yearStr};
                }).toList(),

                onChanged: (String? newValue) {
                  if (newValue != null && newValue.isNotEmpty) {
                    setState(() {
                      _selectedYear = int.tryParse(newValue) ?? _selectedYear;
                    });
                  }
                },
              ),

              SizedBox(height: 15.h),

              BuildDropdown(
                selectedValue: _selectedMonth.toString(),
                selectedLabel: _months[_selectedMonth] ?? '',
                hintText: "Pilih Bulan",

                itemDropdown: _months.entries.map((entry) {
                  return {'value': entry.key.toString(), 'label': entry.value};
                }).toList(),

                onChanged: (String? newValue) {
                  if (newValue != null && newValue.isNotEmpty) {
                    setState(() {
                      _selectedMonth = int.tryParse(newValue) ?? _selectedMonth;
                    });
                  }
                },
              ),
            ],
          ),
        ),
        Obx(() {
          final bool isLoading = widget.isLoading?.value ?? false;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SecondaryColor.danger600,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                  minimumSize: Size(100.w, 48.h),
                ),
                onPressed: isLoading ? null : (widget.onFalsePressed ?? () => Get.back()),
                child: Text(
                  widget.falseText ?? "Batal",
                  style: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.white, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MainColor.blue5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                  minimumSize: Size(100.w, 48.h),
                ),
                onPressed: isLoading
                    ? null
                    : () {
                        widget.onTruePressed?.call(_selectedYear, _selectedMonth);
                      },
                child: isLoading
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: CircularProgressIndicator(color: SecondaryColor.white, strokeWidth: 2.0),
                      )
                    : Text(
                        widget.trueText ?? "Unduh",
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
