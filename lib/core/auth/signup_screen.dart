import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/core/auth/auth_theme.dart';
import 'package:flutter_projects_getx/core/auth/widgets/auth_header.dart';
import 'package:flutter_projects_getx/feature/controller/sign_up_controller.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Scaffold(
      backgroundColor: AuthTheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AuthHeader(
              eyebrow: 'GET STARTED',
              title: 'Create your\nnew account',
              icon: Icons.person_add_rounded,
            ),
            _SignupForm(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _SignupForm extends StatelessWidget {
  final SignupController controller;

  const _SignupForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthInputField(
            controller: controller.nameController,
            label: 'FULL NAME',
            hint: 'John Doe',
            icon: Icons.person_outline_rounded,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 16),
          AuthInputField(
            controller: controller.emailController,
            label: 'EMAIL ADDRESS',
            hint: 'you@example.com',
            icon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _PasswordField(controller: controller),
          const SizedBox(height: 16),
          _ConfirmPasswordField(controller: controller),
          const SizedBox(height: 20),
          _TermsCheckbox(controller: controller),
          const SizedBox(height: 28),
          AuthGradientButton(
            label: 'Create Account',
            onTap: controller.onSignUpTap,
          ),
          const SizedBox(height: 28),
          const AuthDivider(label: 'or sign up with'),
          const SizedBox(height: 20),
          _SocialRow(controller: controller),
          const SizedBox(height: 28),
          AuthBottomText(
            question: 'Already have an account? ',
            actionLabel: 'Log in',
            onTap: controller.onLoginTap,
          ),
        ],
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final SignupController controller;

  const _PasswordField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AuthInputField(
        controller: controller.passwordController,
        label: 'PASSWORD',
        hint: '••••••••',
        icon: Icons.lock_outline_rounded,
        obscureText: !controller.isPasswordVisible.value,
        suffix: IconButton(
          icon: Icon(
            controller.isPasswordVisible.value
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: AuthTheme.textSecondary,
            size: 20,
          ),
          onPressed: controller.togglePasswordVisibility,
        ),
      ),
    );
  }
}

class _ConfirmPasswordField extends StatelessWidget {
  final SignupController controller;

  const _ConfirmPasswordField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AuthInputField(
        controller: controller.confirmPasswordController,
        label: 'CONFIRM PASSWORD',
        hint: '••••••••',
        icon: Icons.lock_outline_rounded,
        obscureText: !controller.isConfirmPasswordVisible.value,
        suffix: IconButton(
          icon: Icon(
            controller.isConfirmPasswordVisible.value
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: AuthTheme.textSecondary,
            size: 20,
          ),
          onPressed: controller.toggleConfirmPasswordVisibility,
        ),
      ),
    );
  }
}

class _TermsCheckbox extends StatelessWidget {
  final SignupController controller;

  const _TermsCheckbox({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: controller.isTermsAccepted.value,
              onChanged: controller.toggleTerms,
              activeColor: AuthTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 13, color: AuthTheme.textSecondary),
                children: [
                  TextSpan(text: 'I agree to the '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      color: AuthTheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: AuthTheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  final SignupController controller;

  const _SocialRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AuthSocialButton(
            label: 'Google',
            icon: Icons.g_mobiledata_rounded,
            iconColor: AuthTheme.googleRed,
            onTap: controller.onGoogleTap,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AuthSocialButton(
            label: 'Apple',
            icon: Icons.apple_rounded,
            iconColor: Colors.black87,
            onTap: controller.onAppleTap,
          ),
        ),
      ],
    );
  }
}
