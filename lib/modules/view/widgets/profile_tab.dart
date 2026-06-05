import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/modules/view/widgets/profile_option_tile.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
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
               CircleAvatar(
                radius: 36,
                backgroundColor: Color(0xFF1D3A5B),
                child: Icon(Icons.person, size: 40, color: Colors.white),
              ),
               SizedBox(height: 16),
               Text(
                'Hello, ETEC',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
               SizedBox(height: 6),
              Text(
                'Premium member · 12 orders this year',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
               SizedBox(height: 28),
              Container(
                decoration: BoxDecoration(
                  color:  Color(0xFF102A4B),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding:  EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text('Balance', style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 10),
                    Text(
                      '\$2,460',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 18),
                    Text(
                      'Rewards points: 2,400',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
               SizedBox(height: 26),
               ProfileOptionTile(
                icon: Icons.favorite_border,
                title: 'Saved Items',
              ),
               SizedBox(height: 16),
               ProfileOptionTile(
                icon: Icons.history,
                title: 'Order History',
              ),
               SizedBox(height: 16),
               ProfileOptionTile(
                icon: Icons.settings_outlined,
                title: 'Settings',
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
