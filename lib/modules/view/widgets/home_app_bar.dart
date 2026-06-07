import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/modules/view/search_screen.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor:  Color(0xFF0D1B2A),
      expandedHeight: 220,
      toolbarHeight: 70,
      elevation: 0,
      title:  Text(
        'Watch ETEC',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
      centerTitle: false,
      leading: IconButton(
        onPressed: () {},
        icon:  Icon(Icons.menu, color: Colors.white),
      ),
      actions: [
        IconButton(
          onPressed: () => Get.to(() =>  SearchScreen()),
          icon:  Icon(Icons.search, color: Colors.white),
        ),
        IconButton(
          onPressed: () {},
          icon:  Icon(Icons.notifications_none, color: Colors.white),
        ),
        IconButton(
          onPressed: () {},
          icon:  Icon(Icons.shopping_bag_outlined, color: Colors.white),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding:  EdgeInsets.only(left: 20, right: 20, bottom: 18),
        expandedTitleScale: 1,
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://i.pinimg.com/1200x/c1/25/c8/c125c8ad376ba1afedee7888f4baea81.jpg',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                     Color(0xFF0D1B2A).withValues(alpha: 0.66),
                     Color(0xFF0D1B2A).withValues(alpha: 0.88),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize:  Size.fromHeight(90),
        child: Container(
          margin:  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding:  EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text(
                'Discover the latest watches',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
