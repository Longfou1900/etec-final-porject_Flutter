import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/modules/controller/home_controller.dart';
import 'package:flutter_projects_getx/modules/view/home_body.dart';
import 'package:flutter_projects_getx/modules/view/widgets/home_bottom_nav.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor:  Color(0xFF0D1B2A),
        body:  HomeBody(),
        bottomNavigationBar:  HomeBottomNav(),
      ),
    );
  }
}
