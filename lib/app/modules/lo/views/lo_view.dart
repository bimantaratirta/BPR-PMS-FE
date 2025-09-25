import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lo_controller.dart';

class LoView extends GetView<LoController> {
  const LoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
