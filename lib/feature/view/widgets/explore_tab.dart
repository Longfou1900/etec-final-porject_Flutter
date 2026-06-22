import 'package:flutter/material.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics:  BouncingScrollPhysics(),
      padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        // REMOVE any NestedScrollView.sliverOverlapAbsorberHandleFor or SliverOverlapInjector lines here
         Text(
          'Explore Products',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // Add your standard list elements here...
      ],
    );
  }
}