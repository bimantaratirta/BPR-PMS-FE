import 'package:bpr_pms/app/widgets/build_navigation/build_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/nasabah_controller.dart';

class NasabahView extends GetView<NasabahController> {
  const NasabahView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NasabahView'), centerTitle: true),
      body: const Center(child: Text('NasabahView is working', style: TextStyle(fontSize: 20))),
      bottomNavigationBar: BuildBottomNavigationBar(),
    );
  }
}
