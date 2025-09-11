import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_profile_detail_controller.dart';

class ProfileProfileDetailView extends GetView<ProfileProfileDetailController> {
  const ProfileProfileDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileProfileDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProfileProfileDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
