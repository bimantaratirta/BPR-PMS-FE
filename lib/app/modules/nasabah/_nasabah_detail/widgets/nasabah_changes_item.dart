import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/data/modules/customer/models/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NasabahChangesItem extends StatefulWidget {
  final UpdateLog log;

  const NasabahChangesItem({super.key, required this.log});

  @override
  _NasabahChangesItemState createState() => _NasabahChangesItemState();
}

class _NasabahChangesItemState extends State<NasabahChangesItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final log = widget.log;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Helper().formatDateTimeToID(log.updatedAt),
                style: Get.textTheme.labelMedium!.copyWith(color: Colors.grey[600]),
              ),
              SizedBox(height: 4),

              Text(
                log.changes ?? "Tidak ada catatan perubahan.",
                style: Get.textTheme.bodyMedium,
                maxLines: isExpanded ? null : 3,
                overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),

              InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? "Sembunyikan" : "Lihat Detail",
                  style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600, color: Get.theme.primaryColor),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
