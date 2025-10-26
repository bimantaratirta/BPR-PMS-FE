import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/office_controller.dart';

class OfficeView extends GetView<OfficeController> {
  const OfficeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OfficeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OfficeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
