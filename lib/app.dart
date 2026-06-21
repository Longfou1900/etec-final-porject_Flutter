import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/core/auth/forgot_password_screen.dart';
import 'package:flutter_projects_getx/core/auth/register_phone_screen.dart';
import 'package:flutter_projects_getx/core/auth/signup_screen.dart';
import 'package:flutter_projects_getx/feature/view/screen/onborading/onborading_view.dart';
import 'package:get/get.dart';
import 'package:flutter_projects_getx/core/auth/auth_check_view.dart';
import 'package:flutter_projects_getx/core/auth/login_screen.dart';
import 'package:flutter_projects_getx/core/theme/dark_mode.dart';
import 'package:flutter_projects_getx/core/theme/light_mode.dart';
import 'package:flutter_projects_getx/feature/binding/home_binding.dart';
import 'package:flutter_projects_getx/feature/view/screen/home_screen/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return // Inside your MyApp class
GetMaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/onboarding', // Start with the Onboarding screen
  getPages: [
    // Onboarding sequence
    GetPage(name: '/onboarding', page: () => OnboardingView()),
    
    // Existing Auth
    GetPage(name: '/auth-check', page: () => const AuthCheckView()),
    GetPage(name: '/login', page: () => LoginScreen()),
    
    // New Registration Flow
    GetPage(name: '/signup', page: () => SignUpScreen()),
    GetPage(name: '/forgot-password', page: () => ForgotPasswordScreen()),
    GetPage(name: '/register-phone', page: () => RegisterPhoneScreen()),
    
    // Home route
    GetPage(
      name: '/home',
      page: () => HomeScreen(title: 'Argumind'),
      binding: HomeBinding(),
    ),
  ],
  theme: LightMode.theme,
  darkTheme: DarkMode.theme,
  themeMode: ThemeMode.system,
);
  }
}