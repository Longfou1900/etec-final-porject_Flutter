import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_projects_getx/core/auth/forgot_password_screen.dart';
import 'package:flutter_projects_getx/core/auth/register_phone_screen.dart';
import 'package:flutter_projects_getx/core/auth/signup_screen.dart';
import 'package:flutter_projects_getx/feature/view/screen/onborading/onborading_view.dart';
import 'package:flutter_projects_getx/feature/view/screen/slasph_screen/splash_screen.dart';
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/onboarding', page: () => OnboardingView()),
        GetPage(name: '/auth-check', page: () => const AuthCheckView()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signup', page: () => const SignupScreen()),
        GetPage(name: '/register', page: () => RegisterPhoneScreen()),
        GetPage(name: '/register-phone', page: () => RegisterPhoneScreen()),
        GetPage(name: '/forgot-password', page: () => ForgotPasswordScreen()),
        GetPage(
          name: '/home',
          page: () => HomeScreen(title: 'Argumind'),
          binding: HomeBinding(),
        ),
      ],
      theme: LightMode.theme,
      darkTheme: DarkMode.theme,
      themeMode: ThemeMode.system,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 350),
    );
  }
}
