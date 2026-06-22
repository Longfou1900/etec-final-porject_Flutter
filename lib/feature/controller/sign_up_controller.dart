
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  void toggleTerms(bool? value) =>
      isTermsAccepted.value = value ?? false;

  void onSignUpTap() {
    if (!isTermsAccepted.value) {
      Get.snackbar(
        'Terms Required',
        'Please accept the terms and conditions to continue.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    // TODO: add validation & auth logic
    Get.offAllNamed('/home');
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
