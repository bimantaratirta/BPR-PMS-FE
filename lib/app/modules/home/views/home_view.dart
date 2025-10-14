import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/common/constant/assets.dart';
import 'package:bpr_pms/app/modules/auth/controllers/auth_controller.dart';
import 'package:bpr_pms/app/widgets/build_navigation/build_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Obx(() {
      return Scaffold(
        backgroundColor: MainColor.blueNormalActive,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: MainColor.blueNormalActive,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25, top: 60, left: 20, right: 20),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Image.asset(ImageAssets.logoBprSahabatSejatiTransparant, scale: 1),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'BPR Sahabat Sejati',
                                  style: Get.textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Program Management System',
                                  style: Get.textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFF2C6BB6),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(radius: 30, backgroundImage: NetworkImage('https://placehold.co/150')),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    authController.user.value?.name ?? '-',
                                    style: Get.textTheme.titleMedium!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    authController.user.value?.role ?? '-',
                                    style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white70),
                                  ),
                                  authController.pickRole.value != UserRole.am
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Divider(color: Colors.white30, height: 20),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        authController.pickRole.value == UserRole.lo
                                                            ? "SLO"
                                                            : authController.pickRole.value == UserRole.slo
                                                            ? "AM"
                                                            : "-",
                                                        style: Get.textTheme.bodyMedium!.copyWith(
                                                          color: Colors.white70,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        authController.user.value?.supervisor?.name ?? '-',
                                                        style: Get.textTheme.bodyMedium!.copyWith(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(width: 1, height: 30, color: Colors.white30),
                                                SizedBox(width: 15),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Kantor',
                                                        style: Get.textTheme.bodyMedium!.copyWith(
                                                          color: Colors.white70,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        authController.user.value?.branch?.branch ?? '-',
                                                        style: Get.textTheme.bodyMedium!.copyWith(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nasabah',
                              style: Get.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: MainColor.greyLightActive,
                              ),
                            ),
                            Text(
                              'Rata - Rata Nasabah',
                              style: Get.textTheme.titleMedium!.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          decoration: BoxDecoration(
                            color: SecondaryColor.neutral100,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: DropdownButton<String>(
                            value: 'Minggu',
                            icon: Icon(Icons.keyboard_arrow_down),
                            underline: SizedBox(),
                            onChanged: (String? newValue) {},
                            items: <String>['Minggu', 'Bulan', 'Tahun'].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: Get.textTheme.bodyMedium!.copyWith(color: MainColor.greyNormal)),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // --- Placeholder untuk Grafik Batang ---
                    Container(
                      height: 200,
                      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      child: const Text('Grafik Batang', style: TextStyle(color: Colors.black54)),
                    ),
                    // --- Ringkasan Statistik ---
                    SizedBox(height: 2000),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BuildBottomNavigationBar(),
      );
    });
  }
}
