import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/modules/customer/customer_service.dart';
import 'package:bpr_pms/app/data/modules/customer/models/customer_model.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NasabahNasabahEditController extends GetxController {
  final CustomerService customerService = CustomerService();

  final RxString id = ''.obs;
  final Rx<CustomerModel?> customerData = Rx<CustomerModel?>(null);
  final isLoading = false.obs;
  final RxString message = ''.obs;
  final RxMap<String, String> validationErrors = <String, String>{}.obs;
  final isFormValid = false.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController identityNumberController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController neighborhoodUnitController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final Rx<DateTime?> selectedDob = Rx<DateTime?>(null);

  RxString selectedItemTypeJob = ''.obs;
  Rx<List<Map<String, String>>> itemsTypeJob = Rx<List<Map<String, String>>>([
    {"value": "", "label": "Pilih tipe pekerjaan"},
    {"value": "businessman", "label": "Wirausaha"},
    {"value": "employee", "label": "Karyawan"},
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
    {"value": "hari", "label": "/hari"},
    {"value": "minggu", "label": "/minggu"},
    {"value": "bulan", "label": "/bulan"},
  ]);

  void changeSelectedItemTypeJob(String value) {
    selectedItemTypeJob.value = value;
    resetJobFields();
    _updateFormValid();
  }

  void changeSelectedItemTypeIncomeJob(String value) {
    selectedItemTypeIncomeJob.value = value;
    _updateFormValid();
  }

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(_updateFormValid);
    identityNumberController.addListener(_updateFormValid);
    dobController.addListener(_updateFormValid);
    phoneNumberController.addListener(_updateFormValid);
    villageController.addListener(_updateFormValid);
    neighborhoodUnitController.addListener(_updateFormValid);
    addressController.addListener(_updateFormValid);
    detailTypeJob.addListener(_updateFormValid);
    jobName.addListener(_updateFormValid);
    jobCompanyName.addListener(_updateFormValid);
    jobAddress.addListener(_updateFormValid);
    jobPhoneNumber.addListener(_updateFormValid);
    jobPosition.addListener(_updateFormValid);
    totalEmployees.addListener(_updateFormValid);
    jobIncome.addListener(_updateFormValid);
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

  void resetForm() {
    nameController.clear();
    identityNumberController.clear();
    dobController.clear();
    phoneNumberController.clear();
    villageController.clear();
    neighborhoodUnitController.clear();
    addressController.clear();
    selectedItemTypeJob.value = '';
    selectedDob.value = null;
    resetJobFields();
    validationErrors.clear();
    message.value = '';
  }

  void _updateFormValid() {
    isFormValid.value = nameController.text.isNotEmpty && addressController.text.isNotEmpty;
  }

  void initializeForm() {
    nameController.text = customerData.value?.name ?? '';
    identityNumberController.text = customerData.value?.ktpNumber ?? '';
    dobController.text = Helper().formatDateTimeToID(customerData.value?.dateOfBirth);
    phoneNumberController.text = customerData.value?.phoneNumber ?? '';
    villageController.text = customerData.value?.village ?? '';
    neighborhoodUnitController.text = customerData.value?.rtRw ?? '';
    addressController.text = customerData.value?.address ?? '';
    selectedDob.value = customerData.value?.dateOfBirth;

    selectedItemTypeJob.value = customerData.value?.workType == 'Karyawan'
        ? 'employee'
        : customerData.value?.workType == 'Wirausaha'
        ? 'businessman'
        : customerData.value?.workType == 'Pekerja Lepas'
        ? 'freelancer'
        : '';

    if (selectedItemTypeJob.value == 'businessman') {
      detailTypeJob.text = customerData.value?.business?.businessType ?? '';
      totalEmployees.text = customerData.value?.business?.employeeCount?.toString() ?? '';
      jobIncome.text = customerData.value?.business?.revenue?.toString() ?? '';
      selectedItemTypeIncomeJob.value = '';
    } else if (selectedItemTypeJob.value == 'employee') {
      jobName.text = customerData.value?.employee?.work ?? '';
      jobCompanyName.text = customerData.value?.employee?.companyName ?? '';
      jobAddress.text = customerData.value?.employee?.companyAddress ?? '';
      jobPhoneNumber.text = customerData.value?.employee?.companyPhone ?? '';
      jobPosition.text = customerData.value?.employee?.position ?? '';
      jobIncome.text = customerData.value?.employee?.salary?.toString() ?? '';
      selectedItemTypeIncomeJob.value = '';
    } else if (selectedItemTypeJob.value == 'freelancer') {
      jobName.text = customerData.value?.nonEmployee?.work ?? '';
      jobIncome.text = customerData.value?.nonEmployee?.salary?.toString() ?? '';
      selectedItemTypeIncomeJob.value = customerData.value?.nonEmployee?.salaryFrequency ?? '';
    }
  }

  String dobIsoUtcZ() {
    if (selectedDob.value != null) {
      final d = selectedDob.value!;
      return DateTime.utc(d.year, d.month, d.day).toIso8601String();
    }

    // Fallback: parse dari text field kalau user somehow isi manual
    final txt = dobController.text.trim();
    if (txt.isEmpty) return '';

    DateTime? parsed;
    // Coba beberapa format umum kamu pakai
    try {
      // format tampilan: "dd MMM yyyy", e.g. "28 Agu 2005"
      parsed = DateFormat('dd MMM yyyy', 'id_ID').parseStrict(txt);
    } catch (_) {}
    try {
      // date-only ISO
      parsed ??= DateFormat('yyyy-MM-dd').parseStrict(txt);
    } catch (_) {}
    if (parsed == null) return '';

    return DateTime.utc(parsed.year, parsed.month, parsed.day).toIso8601String();
  }

  Future<void> pickDob(BuildContext context) async {
    final now = DateTime.now();
    final initial = selectedDob.value ?? DateTime(now.year - 20, now.month, now.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900, 1, 1),
      lastDate: now,
      helpText: 'Pilih tanggal lahir',
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );

    if (picked != null) {
      selectedDob.value = DateTime(picked.year, picked.month, picked.day);
      dobController.text = DateFormat('dd MMM yyyy', 'id_ID').format(selectedDob.value!);
      _updateFormValid();
    }
  }

  Future updateCustomer(BuildContext context) async {
    try {
      validationErrors.clear();
      isLoading.value = true;
      message.value = '';

      final payload = {
        "customer": {
          "name": nameController.text,
          "ktp_number": identityNumberController.text,
          "date_of_birth": dobIsoUtcZ(),
          "phone_number": phoneNumberController.text,
          "village": villageController.text,
          "rt_rw": neighborhoodUnitController.text,
          "address": addressController.text,
          "work_type": selectedItemTypeJob.value == 'employee'
              ? 'Karyawan'
              : selectedItemTypeJob.value == 'businessman'
              ? 'Wirausaha'
              : selectedItemTypeJob.value == 'freelancer'
              ? 'Pekerja Lepas'
              : '',
        },
        ...{
          if (selectedItemTypeJob.value == 'freelancer')
            'non_employee': {
              "work": jobName.text,
              "salary": int.tryParse(jobIncome.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
              "salary_frequency": selectedItemTypeIncomeJob.value,
            },

          if (selectedItemTypeJob.value == 'businessman')
            'business': {
              "business_type": detailTypeJob.text,
              "employee_count": int.tryParse(totalEmployees.text) ?? 0,
              "revenue": int.tryParse(jobIncome.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
            },

          if (selectedItemTypeJob.value == 'employee')
            'employee': {
              "work": jobName.text,
              "company_name": jobCompanyName.text,
              "company_address": jobAddress.text,
              "company_phone": jobPhoneNumber.text,
              "position": jobPosition.text,
              "salary": int.tryParse(jobIncome.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
            },
        },
      };

      final response = await customerService.updateCustomer(id.value, payload);

      isLoading.value = false;

      if (response.code == 200) {
        message.value = "Nasabah berhasil diperbarui!";
        CustomSnackbar(message: message.value, type: CustomSnackbarType.success).show(context);
      } else if (response.code == 422) {
        Map<String, dynamic>? validationErrorsMap;
        if (response.errors is Map<String, dynamic> && response.errors['validation'] is Map<String, dynamic>) {
          validationErrorsMap = response.errors['validation'] as Map<String, dynamic>;

          validationErrorsMap.forEach((fieldKey, errorList) {
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
        String errorMsg = response.message ?? "Nasabah gagal diperbarui. Silakan coba lagi.";
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
