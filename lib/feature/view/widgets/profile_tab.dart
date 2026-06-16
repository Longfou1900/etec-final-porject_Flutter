import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        // REMOVE any NestedScrollView.sliverOverlapAbsorberHandleFor or SliverOverlapInjector lines here
        const Text(
          'User Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // Add your profile options here...
      ],
    );
  }
}