import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/model/home_model.dart';
import 'package:flutter_projects_getx/feature/view/widgets/home_section_title.dart';
import 'package:flutter_projects_getx/feature/view/widgets/latest_product_list.dart';
import 'package:flutter_projects_getx/feature/view/widgets/popular_product_list.dart';

class HomeTab extends StatelessWidget {
  final Data? data;

  const HomeTab(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final popularData = data?.popular;
    final latestData = data?.lates;

    return ListView(
      // BouncingScrollPhysics gives that high-end, smooth iOS feel on both platforms
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        // 1. Popular Products Section
        HomeSectionTitle('Popular', 'Trending this week'),
        const SizedBox(height: 14),
        PopularProductList(products: popularData),
        
        const SizedBox(height: 28),
        
        // 2. Latest Arrivals Section
        HomeSectionTitle('Latest Arrivals', 'Just landed in shop'),
        const SizedBox(height: 14),
        LatestProductList(products: latestData),
        
        // Added bottom safety padding to prevent elements from feeling cramped against the bottom nav bar
        const SizedBox(height: 24),
      ],
    );
  }
}