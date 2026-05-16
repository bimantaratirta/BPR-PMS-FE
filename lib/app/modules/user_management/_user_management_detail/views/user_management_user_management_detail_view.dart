import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_management_user_management_detail_controller.dart';

class UserManagementUserManagementDetailView
    extends GetView<UserManagementUserManagementDetailController> {
  const UserManagementUserManagementDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail User'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          Obx(() {
            final id = controller.id.value;
            if (id.isEmpty) return const SizedBox.shrink();
            return IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => Get.toNamed(Routes.userManagementEdit(id)),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final u = controller.user.value;
        if (u == null) {
          return const Center(child: Text('User tidak ditemukan'));
        }

        Widget row(String label, String? value) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  Expanded(child: Text(value ?? '-')),
                ],
              ),
            );

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              row('Nama', u.name),
              row('Username', u.username),
              row('Role', u.role),
              row('Region', u.region?.region),
              row('Branch', u.branch?.branch),
              row('Supervisor', u.supervisor?.name),
              row('Created', u.createdAt?.toIso8601String()),
              row('Updated', u.updatedAt?.toIso8601String()),
              if (u.deletedAt != null) row('Dinonaktifkan', u.deletedAt!.toIso8601String()),
            ],
          ),
        );
      }),
    );
  }
}
