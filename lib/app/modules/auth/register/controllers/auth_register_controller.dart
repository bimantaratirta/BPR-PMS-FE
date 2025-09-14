import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthRegisterController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Rx<List<String>> typeAccountList = Rx<List<String>>(['LO', 'SLO', 'AM']);
  Rx<String?> pickTypeAccount = Rx<String?>("LO");
  void useTypeAccount(String account) {
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

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
