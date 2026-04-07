import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/modules/user/models/user_model.dart';
import 'package:bpr_pms/app/data/modules/user/user_service.dart';
import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SloController extends GetxController {
  final Helper helper = Helper();
  final AuthController authController = Get.find<AuthController>();
  final UserService userService = UserService();

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  final Rx<List<UserModel>> usersSloData = Rx<List<UserModel>>([]);
  final isLoading = false.obs;
  final RxString message = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMoreData = true.obs;
  final int limit = 5;
  final isPagingLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllSloByAm(Get.context!, isInitialLoad: true);

    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });

    debounce(searchQuery, (_) async {
      currentPage.value = 1;
      hasMoreData.value = true;
      usersSloData.value = [];
      await getAllSloByAm(Get.context!, isInitialLoad: true);
    }, time: const Duration(milliseconds: 1000));
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> refreshData(BuildContext context) async {
    currentPage.value = 1;
    hasMoreData.value = true;
    usersSloData.value = [];
    await getAllSloByAm(context, isInitialLoad: true);
  }

  Future<void> getAllSloByAm(BuildContext context, {bool isInitialLoad = false}) async {
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
        'search': searchController.text.trim(),
        'pagination': {'page': currentPage.value, 'limit': limit},
      };

      final response = await userService.getAllSloByAm(id: authController.user.value?.id ?? "", params: params);

      if (isInitialLoad) {
        isLoading.value = false;
      } else {
        isPagingLoading.value = false;
      }

      if (response.code == 200) {
        final newUsersSlo = response.data ?? [];

        if (currentPage.value == 1) {
          usersSloData.value = newUsersSlo;
        } else {
          usersSloData.value.addAll(newUsersSlo);
          usersSloData.refresh();
        }

        hasMoreData.value = newUsersSlo.length == limit;

        if (hasMoreData.value) {
          currentPage.value++;
        }

        message.value = isInitialLoad
            ? "Data user slo berhasil diambil!"
            : newUsersSlo.isEmpty
            ? "Semua data user slo sudah dimuat."
            : "Data user slo halaman ${currentPage.value - 1} berhasil dimuat!";
      } else {
        String errorMsg = response.message ?? "Data user slo gagal diambil. Silakan coba lagi.";
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
}
