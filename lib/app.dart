import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/core/auth/auth_check_view.dart';
import 'package:flutter_projects_getx/core/auth/login_screen.dart';
import 'package:flutter_projects_getx/core/theme/dark_mode.dart';
import 'package:flutter_projects_getx/core/theme/light_mode.dart';
import 'package:flutter_projects_getx/feature/binding/home_binding.dart';
import 'package:flutter_projects_getx/feature/view/screen/home_view.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // inside MyApp build method
return GetMaterialApp(
  debugShowCheckedModeBanner: false,
  // Use a root controller to determine initial screen
  initialRoute: '/', 
  getPages: [
    GetPage(name: '/', page: () => const AuthCheckView()), // Logic to check token
    GetPage(name: '/home', page: () => HomeView(title: 'Argumind'), binding: HomeBinding()),
    GetPage(name: '/', page: () => LoginScreen()),
    // Ensure the name matches the one used in the navigation call
    GetPage(name: '/home', page: () => HomeView(title: 'Argumind'), binding: HomeBinding()),
  ],
  theme: LightMode.theme,
  darkTheme: DarkMode.theme,
  themeMode: ThemeMode.system,
);
  }
}
