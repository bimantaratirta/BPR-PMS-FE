import 'package:bpr_pms/app/data/modules/branch/branch_service.dart';
import 'package:bpr_pms/app/data/modules/branch/models/branch_model.dart';
import 'package:bpr_pms/app/data/modules/region/models/region_model.dart';
import 'package:bpr_pms/app/data/modules/region/region_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthRegisterController extends GetxController {
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

  Rx<List<String>> typeAccountList = Rx<List<String>>(['LO', 'SLO', 'AM']);
  Rx<String?> pickTypeAccount = Rx<String?>("LO");
  void useTypeAccount(String account) {
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
    selectedItemDropdownOffice.value = value;
  }

  void resetSelectedItemDropdownOffice() {
    selectedItemDropdownOffice.value = '';
  }

  void changeSelectedItemDropdownDistrict(String value) {
    selectedItemDropdownDistrict.value = value;
  }

  void resetSelectedItemDropdownDistrict() {
    selectedItemDropdownDistrict.value = '';
  }

  @override
  void onInit() {
    super.onInit();

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
}
