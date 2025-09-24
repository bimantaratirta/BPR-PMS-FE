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
    {"value": "", "label": "Pilih tipe pekerjaan"},
    {"value": "businessman", "label": "Pengusaha"},
    {"value": "permanentEmployee", "label": "Karyawan Tetap"},
    {"value": "freelancer", "label": "Pekerja Lepas"},
  ]);
  final TextEditingController detailTypeJob = TextEditingController();
  final TextEditingController jobName = TextEditingController();
  final TextEditingController jobCompanyName = TextEditingController();
  final TextEditingController jobAddress = TextEditingController();
  final TextEditingController jobPhoneNumber = TextEditingController();
  final TextEditingController jobPosition = TextEditingController();
  final TextEditingController totalEmployees = TextEditingController();
  final TextEditingController jobIncome = TextEditingController();
  RxString selectedItemTypeIncomeJob = ''.obs;
  Rx<List<Map<String, String>>> itemsTypeIncomeJob = Rx<List<Map<String, String>>>([
    {"value": "", "label": "Pilih satuan"},
    {"value": "daily", "label": "/hari"},
    {"value": "weekly", "label": "/minggu"},
    {"value": "monthly", "label": "/bulan"},
    {"value": "yearly", "label": "/tahun"},
  ]);

  void changeSelectedItemTypeJob(String value) {
    selectedItemTypeJob.value = value;
    resetJobFields();
  }

  void changeSelectedItemTypeIncomeJob(String value) {
    selectedItemTypeIncomeJob.value = value;
  }

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
    detailTypeJob.dispose();
    jobName.dispose();
    jobCompanyName.dispose();
    jobAddress.dispose();
    jobPhoneNumber.dispose();
    jobPosition.dispose();
    totalEmployees.dispose();
    jobIncome.dispose();
  }

  void resetJobFields() {
    detailTypeJob.clear();
    jobName.clear();
    jobCompanyName.clear();
    jobAddress.clear();
    jobPhoneNumber.clear();
    jobPosition.clear();
    totalEmployees.clear();
    jobIncome.clear();
    selectedItemTypeIncomeJob.value = '';
  }
}
