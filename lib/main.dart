import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/app.dart';
import 'package:flutter_projects_getx/core/services/auth_service.dart';
import 'package:flutter_projects_getx/feature/controller/favorite_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get_storage/get_storage.dart';


void main() async {
  await GetStorage.init();
  Get.put(FavoriteController());
  // 1. Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // 2. Put the service into the GetX dependency container
  // Initialize globally
  Get.put(AuthService());  
  runApp(const MyApp());
}