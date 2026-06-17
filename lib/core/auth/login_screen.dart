import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = Get.find<AuthService>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo placeholder or Image
              Icon(Icons.shield_moon_rounded,
                  size: 80, color: Theme.of(context).primaryColor),
              const SizedBox(height: 20),
              Text("Welcome back",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 30),

              // Email Field
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: 'Work Email', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),

              // Password Field
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder()),
                obscureText: true,
              ),
              const SizedBox(height: 24),

              // Sign In Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: // Inside your LoginScreen.dart
                    ElevatedButton(
                  onPressed: () async {
                    // 1. Perform your authentication logic here
                    // await controller.login();

                    // 2. Navigate to the HomeView route
                    Get.offAllNamed('/home');
                  },
                  child: const Text("Sign In"),
                ),
              ),

              // Theme Toggle Button (Connects to your theme controller)
              TextButton(
                onPressed: () => Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark),
                child: Text(Get.isDarkMode
                    ? "Switch to Light Mode"
                    : "Switch to Dark Mode"),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
