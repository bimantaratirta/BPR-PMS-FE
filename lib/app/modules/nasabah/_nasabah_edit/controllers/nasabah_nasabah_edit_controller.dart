import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NasabahNasabahEditController extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
    createDummyData();
  }

  void createDummyData() {
    nameController.text = "Muhammad Rizki";
    identityNumberController.text = "3201012001010001";
    dobController.text = "2001-01-01";
    phoneNumberController.text = "081234567890";
    villageController.text = "Desa Sukamaju";
    neighborhoodUnitController.text = "001/002";
    addressController.text = "Jl. Sukamaju No. 123";

    selectedItemTypeJob.value = "businessman";
    detailTypeJob.text = "Pedagang";
    jobName.text = "Toko Sukses Makmur";
    jobCompanyName.text = "PT. Sukses Makmur";
    jobAddress.text = "Jl. Merdeka No. 45";
    jobPhoneNumber.text = "021-12345678";
    jobPosition.text = "Pemilik";
    totalEmployees.text = "5";
    jobIncome.text = "5000000";
    selectedItemTypeIncomeJob.value = "monthly";
  }
}
