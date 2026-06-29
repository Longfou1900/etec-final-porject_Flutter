import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/core/auth/auth_theme.dart';
import 'package:flutter_projects_getx/core/auth/widgets/auth_header.dart';
import 'package:flutter_projects_getx/core/auth/widgets/glass_container.dart';
import 'package:get/get.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final otpControllers = List.generate(4, (_) => TextEditingController());

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
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
                    Color(0xFFFFFFFF).withOpacity(0.05),
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
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: GlassContainer(
                        padding: EdgeInsets.all(18),
                        borderRadius: BorderRadius.all(Radius.circular(26)),
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
                                icon: Icon(Icons.arrow_back_rounded),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: AuthHeader(
                                eyebrow: 'VERIFICATION',
                                title: 'Enter the OTP',
                                icon: Icons.verified_rounded,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'We sent a 4-digit code to\n+00-1234-567-8912',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AuthTheme.textSecondary),
                            ),
                            SizedBox(height: 26),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(4, (index) {
                                return SizedBox(
                                  width: 60,
                                  child: TextField(
                                    controller: otpControllers[index],
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: AuthTheme.textPrimary,
                                    ),
                                    decoration: InputDecoration(
                                      counterText: '',
                                      filled: true,
                                      fillColor:
                                          // ignore: deprecated_member_use
                                          AuthTheme.surface.withOpacity(0.85),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: AuthTheme.inputBorder,
                                          width: 1.5,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: AuthTheme.primary,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 26),
                            AuthGradientButton(
                              label: 'Submit',
                              onTap: () => Get.offAllNamed('/home'),
                            ),
                            SizedBox(height: 16),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Didn't receive the OTP? Resend",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
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
