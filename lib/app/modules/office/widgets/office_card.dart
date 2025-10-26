import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/data/modules/region/models/region_model.dart';
import 'package:bpr_pms/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfficeCard extends StatelessWidget {
  final RegionModel regionData;

  const OfficeCard({super.key, required this.regionData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.officeDetail(regionData.id ?? ''));
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: MainColor.blue4,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 4))],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Kantor ${regionData.region}',
                        style: Get.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      SizedBox(height: 4),
                      Text('(Unknown) Kantor Kas', style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white)),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 16),

              Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: Image.asset(ImageAssets.officeBackground, fit: BoxFit.cover, alignment: Alignment.center),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
