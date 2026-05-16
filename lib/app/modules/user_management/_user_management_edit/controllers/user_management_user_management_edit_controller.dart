import 'package:bpr_pms/app/data/modules/branch/branch_service.dart';
import 'package:bpr_pms/app/data/modules/branch/models/branch_model.dart';
import 'package:bpr_pms/app/data/modules/region/models/region_model.dart';
import 'package:bpr_pms/app/data/modules/region/region_service.dart';
import 'package:bpr_pms/app/data/modules/user/user_service.dart';
import 'package:bpr_pms/app/modules/user_management/controllers/user_management_controller.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserManagementUserManagementEditController extends GetxController {
  final UserService userService = UserService();
  final RegionService regionService = RegionService();
  final BranchService branchService = BranchService();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();

  final RxnString role = RxnString();
  final RxnString regionId = RxnString();
  final RxnString branchId = RxnString();

  final Rx<List<RegionModel>> regions = Rx<List<RegionModel>>([]);
  final Rx<List<BranchModel>> branches = Rx<List<BranchModel>>([]);

  final isLoading = false.obs;
  final isSubmitting = false.obs;
  final RxString id = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final String? itemId = Get.parameters['id'];
    if (itemId != null) {
      id.value = itemId;
      Future.microtask(() async {
        await _loadRegions();
        await _loadBranches();
        await _loadUser(Get.context!);
      });
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    usernameController.dispose();
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

  Future<void> _loadUser(BuildContext context) async {
    isLoading.value = true;
    final res = await userService.getUserById(id.value);
    isLoading.value = false;
    if (res.code != 200 || res.data == null) {
      CustomSnackbar(
        message: res.message ?? 'Gagal memuat user',
        type: CustomSnackbarType.error,
      ).show(context);
      return;
    }
    final u = res.data!;
    nameController.text = u.name ?? '';
    usernameController.text = u.username ?? '';
    role.value = u.role;
    regionId.value = u.regionId;
    branchId.value = u.branchId;
  }

  void onRoleChanged(String? value) {
    role.value = value;
    regionId.value = null;
    branchId.value = null;
  }

  bool get needsRegion => role.value == 'AM';
  bool get needsBranch => role.value == 'SLO' || role.value == 'LO';

  Future<void> submit(BuildContext context) async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    if (needsRegion && regionId.value == null) {
      CustomSnackbar(message: 'Region wajib dipilih untuk AM', type: CustomSnackbarType.warning).show(context);
      return;
    }
    if (needsBranch && branchId.value == null) {
      CustomSnackbar(message: 'Branch wajib dipilih', type: CustomSnackbarType.warning).show(context);
      return;
    }

    isSubmitting.value = true;
    final body = <String, dynamic>{
      'name': nameController.text.trim(),
      'username': usernameController.text.trim(),
      'role': role.value,
      'region_id': needsRegion ? regionId.value : null,
      'branch_id': needsBranch ? branchId.value : null,
    };

    final response = await userService.updateUser(id.value, body);
    isSubmitting.value = false;

    if (response.code == 200) {
      CustomSnackbar(message: 'User berhasil diupdate', type: CustomSnackbarType.success).show(context);
      if (Get.isRegistered<UserManagementController>()) {
        Get.find<UserManagementController>().refreshData(context);
      }
      Get.back();
    } else {
      CustomSnackbar(
        message: response.message ?? 'Gagal update user',
        type: CustomSnackbarType.error,
      ).show(context);
    }
  }
}
