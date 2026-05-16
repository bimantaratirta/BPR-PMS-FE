import 'package:bpr_pms/app/data/modules/branch/branch_service.dart';
import 'package:bpr_pms/app/data/modules/branch/models/branch_model.dart';
import 'package:bpr_pms/app/data/modules/region/models/region_model.dart';
import 'package:bpr_pms/app/data/modules/region/region_service.dart';
import 'package:bpr_pms/app/data/modules/user/user_service.dart';
import 'package:bpr_pms/app/modules/user_management/controllers/user_management_controller.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserManagementUserManagementCreateController extends GetxController {
  final UserService userService = UserService();
  final RegionService regionService = RegionService();
  final BranchService branchService = BranchService();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  final RxnString role = RxnString();
  final RxnString regionId = RxnString();
  final RxnString branchId = RxnString();

  final Rx<List<RegionModel>> regions = Rx<List<RegionModel>>([]);
  final Rx<List<BranchModel>> branches = Rx<List<BranchModel>>([]);
  final isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadRegions();
    _loadBranches();
  }

  @override
  void onClose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.onClose();
  }

  Future<void> _loadRegions() async {
    final res = await regionService.getAllRegion();
    if (res.code == 200) regions.value = res.data ?? [];
  }

  Future<void> _loadBranches() async {
    final res = await branchService.getAllBranch();
    if (res.code == 200) branches.value = res.data ?? [];
  }

  void onRoleChanged(String? value) {
    role.value = value;
    // Reset region/branch tergantung role baru
    regionId.value = null;
    branchId.value = null;
  }

  bool get needsRegion => role.value == 'AM';
  bool get needsBranch => role.value == 'SLO' || role.value == 'LO';

  Future<void> submit(BuildContext context) async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    if (role.value == null) {
      CustomSnackbar(message: 'Role wajib dipilih', type: CustomSnackbarType.warning).show(context);
      return;
    }
    if (needsRegion && regionId.value == null) {
      CustomSnackbar(message: 'Region wajib dipilih untuk AM', type: CustomSnackbarType.warning).show(context);
      return;
    }
    if (needsBranch && branchId.value == null) {
      CustomSnackbar(message: 'Branch wajib dipilih', type: CustomSnackbarType.warning).show(context);
      return;
    }

    isSubmitting.value = true;
    final body = {
      'name': nameController.text.trim(),
      'username': usernameController.text.trim(),
      'role': role.value,
      'password': passwordController.text,
      'password_confirmation': passwordConfirmController.text,
      if (needsRegion) 'region_id': regionId.value,
      if (needsBranch) 'branch_id': branchId.value,
    };

    final response = await userService.createUser(body);
    isSubmitting.value = false;

    if (response.code == 201 || response.code == 200) {
      CustomSnackbar(message: 'User berhasil dibuat', type: CustomSnackbarType.success).show(context);
      // refresh list jika controller sudah ter-mount
      if (Get.isRegistered<UserManagementController>()) {
        Get.find<UserManagementController>().refreshData(context);
      }
      Get.back();
    } else {
      CustomSnackbar(
        message: response.message ?? 'Gagal membuat user',
        type: CustomSnackbarType.error,
      ).show(context);
    }
  }
}
