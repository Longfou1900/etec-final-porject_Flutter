import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/core/auth/login_screen.dart';
import 'package:flutter_projects_getx/core/services/auth_service.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class AuthCheckView extends StatelessWidget {
  const AuthCheckView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: AuthService().getToken(), // Check if token exists in storage
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final token = snapshot.data;
        final isLoggedIn = token != null && token.isNotEmpty;

        // Redirect only once.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (isLoggedIn) {
            Get.offNamed('/home');
          } else {
            Get.off(() => const LoginScreen());
          }
        });

        return const SizedBox();
      },
    );
  }
}
