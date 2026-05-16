import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_management_user_management_edit_controller.dart';

class UserManagementUserManagementEditView
    extends GetView<UserManagementUserManagementEditController> {
  const UserManagementUserManagementEditView({super.key});

  static const _roleOptions = ['Direksi', 'AM', 'SLO', 'LO'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(labelText: 'Nama Lengkap', border: OutlineInputBorder()),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Wajib diisi';
                    if (v.trim().length < 3) return 'Minimal 3 karakter';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: controller.usernameController,
                  decoration: const InputDecoration(labelText: 'Username', border: OutlineInputBorder()),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Wajib diisi';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: controller.role.value,
                  decoration: const InputDecoration(labelText: 'Role', border: OutlineInputBorder()),
                  items: _roleOptions.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                  onChanged: controller.onRoleChanged,
                  validator: (v) => v == null ? 'Wajib dipilih' : null,
                ),
                const SizedBox(height: 12),
                if (controller.needsRegion) ...[
                  DropdownButtonFormField<String>(
                    value: controller.regionId.value,
                    decoration: const InputDecoration(labelText: 'Region', border: OutlineInputBorder()),
                    items: controller.regions.value
                        .map((r) => DropdownMenuItem(value: r.id, child: Text(r.region ?? '-')))
                        .toList(),
                    onChanged: (v) => controller.regionId.value = v,
                    validator: (v) => v == null ? 'Wajib dipilih' : null,
                  ),
                  const SizedBox(height: 12),
                ],
                if (controller.needsBranch) ...[
                  DropdownButtonFormField<String>(
                    value: controller.branchId.value,
                    decoration: const InputDecoration(labelText: 'Branch', border: OutlineInputBorder()),
                    items: controller.branches.value
                        .map((b) => DropdownMenuItem(value: b.id, child: Text(b.branch ?? '-')))
                        .toList(),
                    onChanged: (v) => controller.branchId.value = v,
                    validator: (v) => v == null ? 'Wajib dipilih' : null,
                  ),
                  const SizedBox(height: 12),
                ],
                ElevatedButton(
                  onPressed: controller.isSubmitting.value ? null : () => controller.submit(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MainColor.blue4,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: controller.isSubmitting.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text('Simpan Perubahan', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
