import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/auth_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  Future<void> onLoginTap() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || !email.contains('@')) {
      Get.snackbar('Invalid email', 'Please enter a valid email address.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (!email.toLowerCase().contains('gmail.com')) {
      Get.snackbar('Use Gmail',
          'Please login using a real Gmail address (example: name@gmail.com).',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (password.isEmpty) {
      Get.snackbar('Invalid password', 'Please enter your password.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      await AuthService().login(email: email, password: password);
      Get.offAllNamed('/home');
    } on Exception catch (e) {
      final msg = e.toString();
      if (msg.contains('User not found')) {
        Get.snackbar('Account not found',
            'No account for this email. Please create one.',
            snackPosition: SnackPosition.BOTTOM);
        Get.offAllNamed('/signup');
        return;
      }
      Get.snackbar('Login failed', msg.replaceFirst('Exception: ', ''),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void onForgotPasswordTap() {
    Get.toNamed('/forgot-password');
  }

  void onGoogleTap() {
    // TODO: Google sign-in
  }

  void onAppleTap() {
    Get.toNamed('/register-phone');
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
