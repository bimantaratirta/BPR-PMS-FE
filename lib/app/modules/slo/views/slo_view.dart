import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/slo_controller.dart';

class SloView extends GetView<SloController> {
  const SloView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SloView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SloView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
