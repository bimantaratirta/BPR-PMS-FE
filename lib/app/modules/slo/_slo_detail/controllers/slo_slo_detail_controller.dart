import 'package:bpr_pms/app/data/modules/user/models/user_model.dart';
import 'package:bpr_pms/app/data/modules/user/user_service.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SloSloDetailController extends GetxController {
  final UserService userService = UserService();

  final RxString id = ''.obs;
  final Rx<UserModel?> userData = Rx<UserModel?>(null);
  final Rx<List<UserModel>> usersLoData = Rx<List<UserModel>>([]);
  final isLoading = false.obs;
  final RxString message = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMoreData = true.obs;
  final int limit = 5;
  final isPagingLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final String? itemId = Get.parameters['id'];

    if (itemId != null) {
      id.value = itemId;
      Future.microtask(() async {
        userData.value = await getUserById(Get.context!, itemId);
        await getAllLoBySlo(Get.context!, itemId, isInitialLoad: true);
      });
    }
  }

  Future<void> refreshData(BuildContext context) async {
    currentPage.value = 1;
    hasMoreData.value = true;
    usersLoData.value = [];
    await getAllLoBySlo(context, id.value, isInitialLoad: true);
  }

  Future<void> getAllLoBySlo(BuildContext context, String id, {bool isInitialLoad = false}) async {
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

      final params = {
        'pagination': {'page': currentPage.value, 'limit': limit},
      };

      final response = await userService.getAllLoBySlo(id: id, params: params);

      if (isInitialLoad) {
        isLoading.value = false;
      } else {
        isPagingLoading.value = false;
      }

      if (response.code == 200) {
        final newUsersLo = response.data ?? [];

        if (currentPage.value == 1) {
          usersLoData.value = newUsersLo;
        } else {
          usersLoData.value.addAll(newUsersLo);
          usersLoData.refresh();
        }

        hasMoreData.value = newUsersLo.length == limit;

        if (hasMoreData.value) {
          currentPage.value++;
        }

        message.value = isInitialLoad
            ? "Data user lo berhasil diambil!"
            : newUsersLo.isEmpty
            ? "Semua data user lo sudah dimuat."
            : "Data user lo halaman ${currentPage.value - 1} berhasil dimuat!";
      } else {
        String errorMsg = response.message ?? "Data user lo gagal diambil. Silakan coba lagi.";
        message.value = errorMsg;
        hasMoreData.value = false;
        CustomSnackbar(message: errorMsg, type: CustomSnackbarType.warning).show(context);
      }
    } catch (e) {
      isLoading.value = false;
      isPagingLoading.value = false;
      hasMoreData.value = false;
      message.value = e.toString();
      CustomSnackbar(message: message.value, type: CustomSnackbarType.error).show(context);
    }
  }

  Future<UserModel?> getUserById(BuildContext context, String id) async {
    try {
      isLoading.value = true;
      message.value = '';

      final response = await userService.getUserById(id);

      isLoading.value = false;

      if (response.code == 200) {
        message.value = "Data pengguna berhasil diambil!";
        userData.value = response.data;
        return response.data;
      } else {
        String errorMsg = response.message ?? "Data pengguna gagal diambil. Silakan coba lagi.";
        message.value = errorMsg;
        CustomSnackbar(message: errorMsg, type: CustomSnackbarType.warning).show(context);
        return null;
      }
    } catch (e) {
      isLoading.value = false;
      message.value = e.toString();
      CustomSnackbar(message: message.value, type: CustomSnackbarType.error).show(context);
      return null;
    }
  }
}
