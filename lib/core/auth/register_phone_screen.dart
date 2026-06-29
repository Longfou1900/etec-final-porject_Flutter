import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/core/auth/auth_theme.dart';
import 'package:flutter_projects_getx/core/auth/widgets/auth_header.dart';
import 'package:flutter_projects_getx/core/auth/widgets/glass_container.dart';
import 'package:flutter_projects_getx/core/auth/opt_vertification_screen.dart';
import 'package:get/get.dart';

class RegisterPhoneScreen extends StatelessWidget {
  const RegisterPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF5F6FF),
                    Color(0xFFE9ECFF),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            left: -90,
            top: -140,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(130),
                gradient: LinearGradient(
                  colors: [
                    // ignore: deprecated_member_use
                    AuthTheme.primary.withOpacity(0.25),
                    // ignore: deprecated_member_use
                    AuthTheme.primaryDark.withOpacity(0.10),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -110,
            bottom: -160,
            child: Container(
              width: 310,
              height: 310,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(155),
                gradient: LinearGradient(
                  colors: [
                    // ignore: deprecated_member_use
                    AuthTheme.primary.withOpacity(0.18),
                    // ignore: deprecated_member_use
                    const Color(0xFFFFFFFF).withOpacity(0.05),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GlassContainer(
                        padding: const EdgeInsets.all(18),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(26)),
                        overlayGradient: LinearGradient(
                          colors: [
                            // ignore: deprecated_member_use
                            Colors.white.withOpacity(0.28),
                            // ignore: deprecated_member_use
                            Colors.white.withOpacity(0.08),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () => Get.back(),
                                icon: const Icon(Icons.arrow_back_rounded),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: AuthHeader(
                                eyebrow: 'PHONE VERIFICATION',
                                title: 'Get a\nOne-Time\nPassword',
                                icon: Icons.phone_android_rounded,
                              ),
                            ),
                            const SizedBox(height: 14),
                            AuthInputField(
                              controller: phoneController,
                              label: 'MOBILE NUMBER',
                              hint: '+00-1234-567-8912',
                              icon: Icons.phone_in_talk_rounded,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 18),
                            AuthGradientButton(
                              label: 'Get OTP',
                              onTap: () =>
                                  Get.to(() => const OtpVerificationScreen()),
                            ),
                            const SizedBox(height: 16),
                            AuthBottomText(
                              question: 'Already have an account? ',
                              actionLabel: 'Log in',
                              onTap: () => Get.toNamed('/login'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
