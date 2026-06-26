import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/core/auth/login_screen.dart';
import 'package:flutter_projects_getx/core/services/auth_service.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class AuthCheckView extends StatelessWidget {
  const AuthCheckView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService().getToken(), // Check if token exists in storage
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData && snapshot.data != null) {
          // Redirect to Home if logged in
          WidgetsBinding.instance
              .addPostFrameCallback((_) => Get.offNamed('/home'));

          return const SizedBox();
        } else {
          // Redirect to Sign In/Sign Up screen
          WidgetsBinding.instance
              .addPostFrameCallback((_) => Get.off(() => LoginScreen()));
          return const SizedBox();
        }
      },
    );
  }
}
