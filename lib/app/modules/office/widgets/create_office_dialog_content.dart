import 'package:bpr_pms/app/modules/office/controllers/office_controller.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:bpr_pms/app/widgets/build_custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bpr_pms/app/common/constant/app_colors.dart';

class CreateOfficeDialogContent extends StatefulWidget {
  const CreateOfficeDialogContent({super.key});

  @override
  State<CreateOfficeDialogContent> createState() => _CreateOfficeDialogContentState();
}

class _CreateOfficeDialogContentState extends State<CreateOfficeDialogContent> {
  final OfficeController officeController = Get.find<OfficeController>();
  late TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> onSubmit(String? name) async {
    await officeController.createRegion(context, name!);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Buat Kantor Baru",
              style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
          ),
          SizedBox(height: 12.h),
          Text("Nama", style: Get.textTheme.labelMedium!.copyWith(letterSpacing: 1, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          BuildCustomTextFormField(
            hintText: "Masukkan nama...",
            controller: nameController,
            maxLines: 1,
            isReadOnly: false,
            isEnable: true,
            withInputFormatter: false,
          ),
          officeController.validationErrors['region'] != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      officeController.validationErrors['region'] ?? '',
                      style: Get.textTheme.bodySmall!.copyWith(color: Colors.red),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
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
                  onPressed: () {
                    if (officeController.isCreateRegionLoading.value) {
                      return;
                    }
                    officeController.validationErrors.clear();
                    Get.back();
                  },
                  child: Text(
                    "Batal",
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
                  onPressed: () async {
                    if (nameController.text.isNotEmpty) {
                      await onSubmit(nameController.text.isEmpty ? null : nameController.text);
                    } else {
                      CustomSnackbar(message: "Nama tidak boleh kosong.", type: CustomSnackbarType.warning).show(context);
                    }
                  },
                  child: officeController.isCreateRegionLoading.value
                      ? SizedBox(
                          width: 16.w,
                          height: 16.h,
                          child: CircularProgressIndicator(color: SecondaryColor.white, strokeWidth: 2),
                        )
                      : Text(
                          "Tambah",
                          style: Get.textTheme.labelMedium!.copyWith(
                            color: SecondaryColor.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
