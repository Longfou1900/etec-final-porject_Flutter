import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  void onLoginTap() {
    // TODO: add validation & auth logic
    Get.offAllNamed('/home');
  }

  void onForgotPasswordTap() {
    Get.toNamed('/forgot-password');
  }

  void onGoogleTap() {
    // TODO: Google sign-in
  }

  void onAppleTap() {
    // TODO: Apple sign-in
  }

  void onSignUpTap() {
    if (Get.key.currentContext != null) {
      Get.toNamed('/signup');
    } else {
      // Handle the case where Get is not initialized
      print("Get is not initialized yet");
    }
  }
}
