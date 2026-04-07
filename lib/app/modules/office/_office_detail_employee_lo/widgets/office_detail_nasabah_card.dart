import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/data/modules/customer/models/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfficeDetailNasabahCard extends StatelessWidget {
  final CustomerModel customerData;

  const OfficeDetailNasabahCard({super.key, required this.customerData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: MainColor.blueLight1,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            SizedBox(
              height: Get.size.height * 0.08,
              width: Get.size.height * 0.08,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: MainColor.blue4),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customerData.name ?? 'Unknown',
                    style: Get.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
