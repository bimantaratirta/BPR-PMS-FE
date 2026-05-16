import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/data/modules/user/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum UserCardAction { detail, edit, resetPassword, delete, restore }

class UserCard extends StatelessWidget {
  final UserModel user;
  final void Function(UserCardAction action) onAction;

  const UserCard({super.key, required this.user, required this.onAction});

  @override
  Widget build(BuildContext context) {
    final bool isDeleted = user.deletedAt != null;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: isDeleted ? SecondaryColor.neutral300 : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: SecondaryColor.neutral300),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: CircleAvatar(
          backgroundColor: isDeleted ? Colors.grey : MainColor.blue4,
          child: const Icon(Icons.person, color: Colors.white),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                user.name ?? user.username ?? 'Unknown',
                style: Get.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDeleted ? Colors.grey : Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isDeleted)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Nonaktif',
                  style: Get.textTheme.labelSmall!.copyWith(color: Colors.red.shade900),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('${user.role ?? '-'} • @${user.username ?? '-'}'),
            if (user.branch?.branch != null) Text('Cabang: ${user.branch!.branch}'),
            if (user.region?.region != null) Text('Region: ${user.region!.region}'),
          ],
        ),
        trailing: PopupMenuButton<UserCardAction>(
          onSelected: onAction,
          itemBuilder: (_) => isDeleted
              ? [
                  const PopupMenuItem(
                    value: UserCardAction.restore,
                    child: Text('Aktifkan kembali'),
                  ),
                ]
              : [
                  const PopupMenuItem(value: UserCardAction.detail, child: Text('Detail')),
                  const PopupMenuItem(value: UserCardAction.edit, child: Text('Edit')),
                  const PopupMenuItem(
                    value: UserCardAction.resetPassword,
                    child: Text('Reset Password'),
                  ),
                  const PopupMenuItem(
                    value: UserCardAction.delete,
                    child: Text('Hapus', style: TextStyle(color: Colors.red)),
                  ),
                ],
        ),
      ),
    );
  }
}
