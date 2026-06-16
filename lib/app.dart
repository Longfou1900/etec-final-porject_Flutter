import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/core/theme/dark_mode.dart';
import 'package:flutter_projects_getx/core/theme/light_mode.dart';
import 'package:flutter_projects_getx/feature/binding/home_binding.dart';
import 'package:flutter_projects_getx/feature/view/screen/home_view.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(title: ''),
      initialBinding: HomeBinding(),
      theme: LightMode.theme,
      darkTheme: DarkMode.theme,
      // themeMode will be controlled from HomeController via Get.changeThemeMode()
      themeMode: ThemeMode.system,
    );
  }
}
