import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/office_office_detail_employee_lo_controller.dart';

class OfficeOfficeDetailEmployeeLoView extends GetView<OfficeOfficeDetailEmployeeLoController> {
  const OfficeOfficeDetailEmployeeLoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OfficeOfficeDetailEmployeeLoView'), centerTitle: true),
      body: const Center(child: Text('OfficeOfficeDetailEmployeeLoView is working', style: TextStyle(fontSize: 20))),
    );
  }
}
