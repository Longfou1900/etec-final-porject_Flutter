import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/core/auth/auth_theme.dart';
import 'package:flutter_projects_getx/core/auth/widgets/auth_header.dart';
import 'package:flutter_projects_getx/feature/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: AuthTheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AuthHeader(
              eyebrow: 'WELCOME BACK',
              title: 'Sign in to your\naccount',
              icon: Icons.watch_rounded,
            ),
            _LoginForm(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final LoginController controller;

  const _LoginForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthInputField(
            controller: controller.emailController,
            label: 'EMAIL ADDRESS',
            hint: 'you@example.com',
            icon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _PasswordField(controller: controller),
          _ForgotPasswordButton(onTap: controller.onForgotPasswordTap),
          const SizedBox(height: 8),
          AuthGradientButton(
            label: 'Log In',
            onTap: controller.onLoginTap,
          ),
          const SizedBox(height: 28),
          const AuthDivider(label: 'or continue with'),
          const SizedBox(height: 20),
          _SocialRow(controller: controller),
          const SizedBox(height: 28),
          AuthBottomText(
            question: "Don't have an account? ",
            actionLabel: 'Sign up',
            onTap: controller.onSignUpTap,
          ),
        ],
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final LoginController controller;

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

class _ForgotPasswordButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ForgotPasswordButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: AuthTheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
        child: const Text(
          'Forgot password?',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  final LoginController controller;

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
