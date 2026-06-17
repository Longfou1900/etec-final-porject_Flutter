import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/app.dart';
import 'package:flutter_projects_getx/core/services/auth_service.dart';
import 'package:flutter_projects_getx/feature/controller/favorite_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';


void main() {
  Get.put(FavoriteController());
  // 1. Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Put the service into the GetX dependency container
  Get.put(AuthService()); // Initialize globally
  runApp(const MyApp());
}



