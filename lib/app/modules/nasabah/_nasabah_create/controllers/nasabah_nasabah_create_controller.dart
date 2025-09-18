import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NasabahNasabahCreateController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController identityNumberController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController neighborhoodUnitController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  RxString selectedItemTypeJob = ''.obs;
  Rx<List<Map<String, String>>> itemsTypeJob = Rx<List<Map<String, String>>>([
    {"value": "", "label": "Pilih tipe pekerjaan..."},
  ]);

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    identityNumberController.dispose();
    dobController.dispose();
    phoneNumberController.dispose();
    villageController.dispose();
    neighborhoodUnitController.dispose();
    addressController.dispose();
  }

  void changeSelectedItemTypeJob(String value) {
    selectedItemTypeJob.value = value;
  }
}
