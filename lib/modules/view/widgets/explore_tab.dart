import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/modules/view/widgets/explore_card.dart';
import 'package:flutter_projects_getx/modules/view/widgets/home_section_title.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Luxury',
      'Sport',
      'Classic',
      'Smart',
      'Minimal',
      'Street',
    ];

    final overlapHandle = NestedScrollView.sliverOverlapAbsorberHandleFor(
      context,
    );

    return CustomScrollView(
      primary: false,
      physics:  BouncingScrollPhysics(),
      slivers: [
        SliverOverlapInjector(handle: overlapHandle),
        SliverPadding(
          padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
               HomeSectionTitle('Explore', 'Browse curated collections'),
               SizedBox(height: 20),
              Wrap(
                spacing: 14,
                runSpacing: 14,
                children: categories
                    .map(
                      (category) => Chip(
                        label: Text(
                          category,
                          style:  TextStyle(fontWeight: FontWeight.w600),
                        ),
                        backgroundColor:  Color(0xFF1E3552),
                        labelStyle:  TextStyle(color: Colors.white),
                        padding:  EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    )
                    .toList(),
              ),
               SizedBox(height: 32),
               Text(
                'Featured designers',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
               SizedBox(height: 16),
              Row(
                children:  [
                  Expanded(
                    child: ExploreCard(
                      title: 'Modern Style',
                      icon: Icons.watch,
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: ExploreCard(
                      title: 'Bold Design',
                      icon: Icons.watch_later,
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
