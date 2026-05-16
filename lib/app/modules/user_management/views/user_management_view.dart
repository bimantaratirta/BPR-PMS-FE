import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/modules/user_management/widgets/user_card.dart';
import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_management_controller.dart';

class UserManagementView extends GetView<UserManagementController> {
  const UserManagementView({super.key});

  static const _roleOptions = ['Direksi', 'AM', 'SLO', 'LO', 'PIC'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen User'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Cari user (nama / role)...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                isDense: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(
              () => DropdownButtonFormField<String?>(
                value: controller.filterRole.value,
                isDense: true,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                items: [
                  const DropdownMenuItem<String?>(value: null, child: Text('Semua')),
                  ..._roleOptions.map(
                    (r) => DropdownMenuItem<String?>(value: r, child: Text(r)),
                  ),
                ],
                onChanged: controller.setRoleFilter,
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.users.value.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.users.value.isEmpty) {
                return Center(
                  child: Text(
                    controller.message.value.isEmpty
                        ? 'Tidak ada user.'
                        : controller.message.value,
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () => controller.refreshData(context),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notif) {
                    if (notif.metrics.pixels >= notif.metrics.maxScrollExtent - 200 &&
                        !controller.isPagingLoading.value &&
                        controller.hasMoreData.value) {
                      controller.fetchUsers(context);
                    }
                    return false;
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: controller.users.value.length + (controller.isPagingLoading.value ? 1 : 0),
                    itemBuilder: (_, index) {
                      if (index >= controller.users.value.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final user = controller.users.value[index];
                      return UserCard(
                        user: user,
                        onAction: (action) {
                          switch (action) {
                            case UserCardAction.detail:
                              Get.toNamed(Routes.userManagementDetail(user.id ?? ''));
                              break;
                            case UserCardAction.edit:
                              Get.toNamed(Routes.userManagementEdit(user.id ?? ''));
                              break;
                            case UserCardAction.resetPassword:
                              controller.resetPassword(context, user);
                              break;
                            case UserCardAction.delete:
                              controller.deleteUser(context, user);
                              break;
                            case UserCardAction.restore:
                              controller.restoreUser(context, user);
                              break;
                          }
                        },
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: MainColor.blue4,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Tambah User', style: TextStyle(color: Colors.white)),
        onPressed: () => Get.toNamed(Routes.userManagementCreate()),
      ),
    );
  }
}
