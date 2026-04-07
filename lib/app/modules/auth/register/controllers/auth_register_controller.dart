import 'package:bpr_pms/app/data/modules/auth/auth_service.dart';
import 'package:bpr_pms/app/data/modules/branch/branch_service.dart';
import 'package:bpr_pms/app/data/modules/branch/models/branch_model.dart';
import 'package:bpr_pms/app/data/modules/region/models/region_model.dart';
import 'package:bpr_pms/app/data/modules/region/region_service.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthRegisterController extends GetxController {
  final AuthService authService = AuthService();
  final BranchService branchService = BranchService();
  final RegionService regionService = RegionService();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  void togglePasswordVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  final TextEditingController confirmPasswordController = TextEditingController();
  RxBool isConfirmPasswordVisible = false.obs;
  void toggleConfirmPasswordVisible() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  final isLoading = false.obs;
  final RxString message = ''.obs;
  final RxMap<String, String> validationErrors = <String, String>{}.obs;
  final isFormValid = false.obs;

  Rx<List<String>> typeAccountList = Rx<List<String>>(['LO', 'SLO', 'AM']);
  Rx<String?> pickTypeAccount = Rx<String?>("LO");
  void useTypeAccount(String account) {
    _updateFormValid();
    resetSelectedItemDropdownDistrict();
    resetSelectedItemDropdownOffice();
    pickTypeAccount.value = account;
  }

  RxString selectedItemDropdownOffice = ''.obs;
  Rx<List<Map<String, String>>> itemDropdownOffice = Rx<List<Map<String, String>>>([
    {"value": "", "label": "Pilih Kantor"},
  ]);

  RxString selectedItemDropdownDistrict = ''.obs;
  Rx<List<Map<String, String>>> itemDropdownDistrict = Rx<List<Map<String, String>>>([
    {"value": "", "label": "Pilih Wilayah"},
  ]);

  void changeSelectedItemDropdownOffice(String value) {
    _updateFormValid();
    selectedItemDropdownOffice.value = value;
  }

  void resetSelectedItemDropdownOffice() {
    selectedItemDropdownOffice.value = '';
  }

  void changeSelectedItemDropdownDistrict(String value) {
    _updateFormValid();
    selectedItemDropdownDistrict.value = value;
  }

  void resetSelectedItemDropdownDistrict() {
    selectedItemDropdownDistrict.value = '';
  }

  void _updateFormValid() {
    isFormValid.value =
        usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        pickTypeAccount.value != null &&
        pickTypeAccount.value != '' &&
        ((pickTypeAccount.value == 'LO' && selectedItemDropdownOffice.value != '') ||
            (pickTypeAccount.value == 'SLO' && selectedItemDropdownOffice.value != '') ||
            (pickTypeAccount.value == 'AM' && selectedItemDropdownDistrict.value != ''));
  }

  @override
  void onInit() {
    super.onInit();
    usernameController.addListener(_updateFormValid);
    passwordController.addListener(_updateFormValid);
    nameController.addListener(_updateFormValid);
    confirmPasswordController.addListener(_updateFormValid);

    regionService.getAllRegion().then((response) {
      if (response.code == 200) {
        print("Region: ${response.data}");
        List<RegionModel> data = response.data ?? [];
        List<Map<String, String>> tempList = [
          {"value": "", "label": "Pilih Kantor"},
        ];
        for (var item in data) {
          tempList.add({"value": item.id.toString(), "label": item.region.toString()});
        }
        itemDropdownDistrict.value = tempList;
        itemDropdownDistrict.refresh();
      }
    });

    branchService.getAllBranch().then((response) {
      if (response.code == 200) {
        print("Branch: ${response.data}");
        List<BranchModel> data = response.data ?? [];
        List<Map<String, String>> tempList = [
          {"value": "", "label": "Pilih Kantor"},
        ];
        for (var item in data) {
          tempList.add({"value": item.id.toString(), "label": item.branch.toString()});
        }
        itemDropdownOffice.value = tempList;
        itemDropdownOffice.refresh();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    usernameController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  Future register(BuildContext context) async {
    try {
      validationErrors.clear();
      isLoading.value = true;
      message.value = '';

      final payload = {
        "name": nameController.text,
        "username": usernameController.text,
        "password": passwordController.text,
        "password_confirmation": confirmPasswordController.text,
        "role": pickTypeAccount.value,
        ...{
          if (pickTypeAccount.value == 'LO' || pickTypeAccount.value == 'SLO') 'branch_id': selectedItemDropdownOffice.value,
          if (pickTypeAccount.value == 'AM') 'region_id': selectedItemDropdownDistrict.value,
        },
      };
      final response = await authService.register(payload);

      isLoading.value = false;

      if (response.code == 201) {
        message.value = "Register berhasil!";
        CustomSnackbar(message: message.value, type: CustomSnackbarType.success).show(context);
        Get.back();
      } else if (response.code == 422) {
        Map<String, dynamic>? validationErrorsMap;
        if (response.errors is Map<String, dynamic> && response.errors['validation'] is Map<String, dynamic>) {
          validationErrorsMap = response.errors['validation'] as Map<String, dynamic>;

          validationErrorsMap.forEach((fieldKey, errorList) {
            if (fieldKey == 'branch_id' || fieldKey == 'region_id') {
              CustomSnackbar(message: errorList[0].toString(), type: CustomSnackbarType.warning).show(context);
            }
            if (errorList is List && errorList.isNotEmpty) {
              validationErrors[fieldKey] = errorList[0].toString();
            }
          });

          validationErrors.refresh();
          message.value = 'Validasi gagal. Periksa input Anda.';
        } else if (response.error != null) {
          message.value = response.error.toString();
        } else {
          message.value = 'Validasi gagal. Periksa input Anda.';
        }

        isLoading.value = false;
      } else {
        String errorMsg = response.message ?? "Register gagal. Silakan coba lagi.";
        message.value = errorMsg;
        CustomSnackbar(message: errorMsg, type: CustomSnackbarType.warning).show(context);
      }
    } catch (e) {
      isLoading.value = false;
      message.value = e.toString();
      CustomSnackbar(message: message.value, type: CustomSnackbarType.error).show(context);
    }
  }
}
