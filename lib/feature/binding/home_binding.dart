import 'package:flutter_projects_getx/feature/controller/cart_controller.dart';
import 'package:flutter_projects_getx/feature/controller/home_controller.dart';
import 'package:get/instance_manager.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(CartController());
  }
}


