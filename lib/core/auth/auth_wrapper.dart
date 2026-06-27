import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'auth_theme.dart';
import 'widgets/glass_container.dart';

class AuthWrapper extends StatelessWidget {
  final Widget child;
  final String title;
  const AuthWrapper({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
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
            top: -160,
            child: Container(
              width: 270,
              height: 270,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(135),
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
            right: -120,
            bottom: -180,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(175),
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close,
                            color: AuthTheme.textPrimary),
                        onPressed: () => Get.back(),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          color: AuthTheme.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GlassContainer(
                      padding: const EdgeInsets.all(22),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      overlayGradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.26),
                          Colors.white.withOpacity(0.06),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      child: child,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
