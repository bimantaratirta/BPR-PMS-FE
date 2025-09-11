import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_profile_change_password_controller.dart';

class ProfileProfileChangePasswordView
    extends GetView<ProfileProfileChangePasswordController> {
  const ProfileProfileChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileProfileChangePasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProfileProfileChangePasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
