import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/modules/user/models/user_model.dart';
import 'package:bpr_pms/app/data/modules/user/user_service.dart';
import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfficeOfficeDetailEmployeeController extends GetxController {
  final Helper helper = Helper();
  final AuthController authController = Get.find<AuthController>();
  final UserService userService = UserService();

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  final RxString id = ''.obs;
  final Rx<List<UserModel>> employeesData = Rx<List<UserModel>>([]);
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
        await getAllEmployees(Get.context!, itemId, isInitialLoad: true);
      });
    }

    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });

    debounce(searchQuery, (_) async {
      currentPage.value = 1;
      hasMoreData.value = true;
      employeesData.value = [];
      await getAllEmployees(Get.context!, id.value, isInitialLoad: true);
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
    employeesData.value = [];
    await getAllEmployees(context, id.value, isInitialLoad: true);
  }

  Future<void> getAllEmployees(BuildContext context, String branchId, {bool isInitialLoad = false}) async {
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
        'filter': {'branch_id': branchId},
      };

      final response = await userService.getAllUsers(params);

      if (isInitialLoad) {
        isLoading.value = false;
      } else {
        isPagingLoading.value = false;
      }

      if (response.code == 200) {
        final newUserEmployees = response.data ?? [];

        if (currentPage.value == 1) {
          employeesData.value = newUserEmployees;
        } else {
          employeesData.value.addAll(newUserEmployees);
          employeesData.refresh();
        }

        hasMoreData.value = newUserEmployees.length == limit;

        if (hasMoreData.value) {
          currentPage.value++;
        }

        message.value = isInitialLoad
            ? "Data kayawan berhasil diambil!"
            : newUserEmployees.isEmpty
            ? "Semua data kayawan sudah dimuat."
            : "Data kayawan halaman ${currentPage.value - 1} berhasil dimuat!";
      } else {
        String errorMsg = response.message ?? "Data kayawan gagal diambil. Silakan coba lagi.";
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
