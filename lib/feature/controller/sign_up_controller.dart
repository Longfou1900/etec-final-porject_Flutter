import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/auth_service.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isTermsAccepted = false.obs;

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;

  void toggleTerms(bool? value) => isTermsAccepted.value = value ?? false;

  Future<void> onSignUpTap() async {
    if (!isTermsAccepted.value) {
      Get.snackbar(
        'Terms Required',
        'Please accept the terms and conditions to continue.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final fullName = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (fullName.isEmpty) {
      Get.snackbar('Invalid name', 'Please enter your full name.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (email.isEmpty || !email.contains('@')) {
      Get.snackbar('Invalid email', 'Please enter a valid email address.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (!email.toLowerCase().contains('gmail.com')) {
      Get.snackbar('Use Gmail',
          'Please sign up using a real Gmail address (example: name@gmail.com).',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (password.isEmpty) {
      Get.snackbar('Invalid password', 'Please enter your password.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (confirmPassword != password) {
      Get.snackbar(
          'Password mismatch', 'Password and confirm password do not match.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      await AuthService().register(
        fullName: fullName,
        email: email,
        role: 'user',
        password: password,
      );

      Get.offAllNamed('/home');
    } on Exception catch (e) {
      Get.snackbar(
          'Sign up failed', e.toString().replaceFirst('Exception: ', ''),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void onGoogleTap() {
    // TODO: Google sign-in
  }

  void onAppleTap() {
    // TODO: Apple sign-in
  }

  void onLoginTap() => Get.back();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
