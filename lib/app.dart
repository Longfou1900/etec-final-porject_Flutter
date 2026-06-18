import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Ensure correct import
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
      initialRoute: '/auth-check', // Unique initial route
      getPages: [
        // Auth check logic
        GetPage(
          name: '/auth-check', 
          page: () => const AuthCheckView()
        ),
        // Login route
        GetPage(
          name: '/login', 
          page: () => LoginScreen()
        ),
        // Home route
        GetPage(
          name: '/home',
          page: () =>  HomeScreen(title: 'Argumind'),
          binding: HomeBinding(),
        ),
      ],
      theme: LightMode.theme,
      darkTheme: DarkMode.theme,
      themeMode: ThemeMode.system,
    );
  }
}