import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/controller/home_controller.dart';
import 'package:flutter_projects_getx/feature/view/widgets/explore_tab.dart';
import 'package:flutter_projects_getx/feature/view/widgets/home_app_bar.dart';
import 'package:flutter_projects_getx/feature/view/widgets/home_tab.dart';
import 'package:flutter_projects_getx/feature/view/widgets/profile_tab.dart';
import 'package:get/get.dart';

class HomeBody extends GetView<HomeController> {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      physics:  BouncingScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: Obx(
              () => controller.selectedIndex.value == 0
                  ? const HomeAppBar()
                  : const SliverToBoxAdapter(child: SizedBox.shrink()),
            ),
          ),
        ];
      },
      body: Obx(
        () => controller.lodaing.value
            ?  Center(child: CircularProgressIndicator())
            : IndexedStack(
                index: controller.selectedIndex.value,
                children: [
                  HomeTab(controller.homeModel.data),
                   ExploreTab(),
                   ProfileTab(),
                ],
              ),
      ),
    );
  }
}
