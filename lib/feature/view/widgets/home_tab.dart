import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/model/home_model.dart';
import 'package:flutter_projects_getx/feature/view/widgets/home_section_title.dart';
import 'package:flutter_projects_getx/feature/view/widgets/latest_product_list.dart';
import 'package:flutter_projects_getx/feature/view/widgets/product_cards.dart';

class HomeTab extends StatelessWidget {
  final Data? data;

  const HomeTab(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final popularData = data?.popular;
    final latestData = data?.lates;

    final overlapHandle = NestedScrollView.sliverOverlapAbsorberHandleFor(
      context,
    );

    return CustomScrollView(
      primary: false,
      physics:  BouncingScrollPhysics(),
      slivers: [
        SliverOverlapInjector(handle: overlapHandle),
        SliverPadding(
          padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
               HomeSectionTitle('Popular', 'Trending this week'),
               SizedBox(height: 16),
              PopularProductList(products: popularData),
               SizedBox(height: 28),
               HomeSectionTitle('Latest Arrivals', 'Just landed in shop'),
               SizedBox(height: 16),
              LatestProductList(products: latestData),
               SizedBox(height: 20),
            ]),
          ),
        ),
      ],
    );
  }
}
