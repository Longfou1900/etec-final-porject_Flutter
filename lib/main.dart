import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/app.dart';
import 'package:flutter_projects_getx/feature/controller/favorite_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';


void main() {
  Get.put(FavoriteController()); // Initialize globally
  runApp(const MyApp());
}



