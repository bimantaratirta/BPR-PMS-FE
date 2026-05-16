import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/modules/user/models/user_model.dart';
import 'package:bpr_pms/app/data/modules/user/user_service.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserManagementController extends GetxController {
  final Helper helper = Helper();
  final UserService userService = UserService();

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  final RxnString filterRole = RxnString();
  final RxnString filterBranchId = RxnString();
  final RxnString filterRegionId = RxnString();

  final Rx<List<UserModel>> users = Rx<List<UserModel>>([]);
  final isLoading = false.obs;
  final isPagingLoading = false.obs;
  final RxString message = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMoreData = true.obs;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    fetchUsers(Get.context!, isInitialLoad: true);

    searchController.addListener(() => searchQuery.value = searchController.text);
    debounce(searchQuery, (_) => _reload(), time: const Duration(milliseconds: 600));
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> _reload() async {
    currentPage.value = 1;
    hasMoreData.value = true;
    users.value = [];
    await fetchUsers(Get.context!, isInitialLoad: true);
  }

  Future<void> refreshData(BuildContext context) async => _reload();

  void setRoleFilter(String? role) {
    filterRole.value = role;
    _reload();
  }

  void setBranchFilter(String? id) {
    filterBranchId.value = id;
    _reload();
  }

  void setRegionFilter(String? id) {
    filterRegionId.value = id;
    _reload();
  }

  Future<void> fetchUsers(BuildContext context, {bool isInitialLoad = false}) async {
    if ((isInitialLoad && isLoading.value) ||
        (!isInitialLoad && (isLoading.value || isPagingLoading.value || !hasMoreData.value))) {
      return;
    }

    try {
      if (isInitialLoad) {
        isLoading.value = true;
        message.value = '';
      } else {
        isPagingLoading.value = true;
      }

      final Map<String, dynamic> filter = {};
      if (filterRole.value != null && filterRole.value!.isNotEmpty) filter['role'] = filterRole.value;
      if (filterBranchId.value != null) filter['branch_id'] = filterBranchId.value;
      if (filterRegionId.value != null) filter['region_id'] = filterRegionId.value;

      final params = <String, dynamic>{
        'search': searchController.text.trim(),
        'pagination': {'page': currentPage.value, 'limit': limit},
        if (filter.isNotEmpty) 'filter': filter,
      };

      final response = await userService.getAllUsers(params);

      if (isInitialLoad) {
        isLoading.value = false;
      } else {
        isPagingLoading.value = false;
      }

      if (response.code == 200) {
        final List<UserModel> incoming = response.data ?? [];
        if (currentPage.value == 1) {
          users.value = incoming;
        } else {
          users.value.addAll(incoming);
          users.refresh();
        }

        hasMoreData.value = incoming.length == limit;
        if (hasMoreData.value) currentPage.value++;

        message.value = 'Data user berhasil diambil';
      } else {
        final errorMsg = response.message ?? 'Gagal memuat user';
        message.value = errorMsg;
        hasMoreData.value = false;
        CustomSnackbar(message: errorMsg, type: CustomSnackbarType.warning).show(context);
      }
    } catch (e) {
      isLoading.value = false;
      isPagingLoading.value = false;
      hasMoreData.value = false;
      message.value = e.toString();
      CustomSnackbar(message: e.toString(), type: CustomSnackbarType.error).show(context);
    }
  }

  Future<void> deleteUser(BuildContext context, UserModel user) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Hapus User'),
        content: Text('Yakin mau menonaktifkan user "${user.name ?? user.username}"?'),
        actions: [
          TextButton(onPressed: () => Get.back(result: false), child: const Text('Batal')),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final response = await userService.deleteUser(user.id ?? '');
    if (response.code == 200) {
      CustomSnackbar(message: 'User dinonaktifkan', type: CustomSnackbarType.success).show(context);
      _reload();
    } else {
      CustomSnackbar(
        message: response.message ?? 'Gagal menonaktifkan user',
        type: CustomSnackbarType.error,
      ).show(context);
    }
  }

  Future<void> restoreUser(BuildContext context, UserModel user) async {
    final response = await userService.restoreUser(user.id ?? '');
    if (response.code == 200) {
      CustomSnackbar(message: 'User diaktifkan kembali', type: CustomSnackbarType.success).show(context);
      _reload();
    } else {
      CustomSnackbar(
        message: response.message ?? 'Gagal mengaktifkan user',
        type: CustomSnackbarType.error,
      ).show(context);
    }
  }

  Future<void> resetPassword(BuildContext context, UserModel user) async {
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final submitted = await Get.dialog<bool>(
      AlertDialog(
        title: Text('Reset Password — ${user.name ?? user.username}'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password Baru'),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Wajib diisi';
                  if (v.length < 8) return 'Minimal 8 karakter';
                  if (!RegExp(r'^(?=.*[A-Z])(?=.*[^a-zA-Z0-9]).{8,}$').hasMatch(v)) {
                    return 'Min 1 huruf besar & 1 simbol';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Konfirmasi Password'),
                validator: (v) {
                  if (v != newPasswordController.text) return 'Tidak sama dgn password baru';
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(result: false), child: const Text('Batal')),
          TextButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) Get.back(result: true);
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (submitted != true) return;

    final response = await userService.resetPassword(user.id ?? '', {
      'password': newPasswordController.text,
      'password_confirmation': confirmPasswordController.text,
    });

    if (response.code == 200) {
      CustomSnackbar(message: 'Password berhasil di-reset', type: CustomSnackbarType.success).show(context);
    } else {
      CustomSnackbar(
        message: response.message ?? 'Gagal reset password',
        type: CustomSnackbarType.error,
      ).show(context);
    }
  }
}
