import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/modules/controller/home_controller.dart';
import 'package:flutter_projects_getx/modules/model/home_model.dart';
import 'package:flutter_projects_getx/modules/view/search_screen.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  final PageController _pageController = PageController();
  Timer? _slideTimer;
  int _currentSlide = 0;

  @override
  void initState() {
    super.initState();
    _slideTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients) return;

      final controller = Get.find<HomeController>();
      final slideCount = _slideItems(controller).length;
      if (slideCount <= 1) return;

      _currentSlide = (_currentSlide + 1) % slideCount;
      _pageController.animateToPage(
        _currentSlide,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _slideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  List<Late> _slideItems(HomeController controller) {
    final popularItems = controller.homeModel.data?.popular ?? [];
    final latestItems = controller.homeModel.data?.lates ?? [];

    return [...popularItems, ...latestItems]
        .where((item) => item.hasValidImage)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: const Color(0xFF0D1B2A),
      expandedHeight: 280,
      toolbarHeight: 76,
      elevation: 0,
      leadingWidth: 76,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Center(
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.watch_outlined,
              color: Color(0xFF0D1B2A),
              size: 24,
            ),
          ),
        ),
      ),
      titleSpacing: 10,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Watch ETEC',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(height: 2),
          Text(
            'Premium watches',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      centerTitle: false,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            onPressed: () => Get.to(() => SearchScreen()),
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 20, right: 20, bottom: 18),
        expandedTitleScale: 1,
        background: Container(
          color: const Color(0xFF0D1B2A),
          padding: const EdgeInsets.fromLTRB(20, 98, 20, 18),
          child: Obx(
            () {
              final slideItems = _slideItems(controller);

              if (controller.lodaing.value || slideItems.isEmpty) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF172638),
                    borderRadius: BorderRadius.circular(28),
                  ),
                );
              }

              return ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: slideItems.length,
                      onPageChanged: (index) {
                        if (!mounted) return;
                        setState(() => _currentSlide = index);
                      },
                      itemBuilder: (context, index) {
                        return _PromoSlide(item: slideItems[index]);
                      },
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 14,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          slideItems.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: index == _currentSlide ? 22 : 7,
                            height: 7,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              color: index == _currentSlide
                                  ? const Color(0xFF8AF05B)
                                  : Colors.white.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PromoSlide extends StatelessWidget {
  final Late item;

  const _PromoSlide({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF202524),
      child: Stack(
        children: [
          Positioned(
            right: -18,
            top: 15,
            bottom: -14,
            width: 190,
            child: Image.network(
              item.images ?? '',
              fit: BoxFit.contain,
              alignment: Alignment.centerRight,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox.shrink();
              },
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFF202524),
                    const Color(0xFF202524).withValues(alpha: 0.88),
                    const Color(0xFF202524).withValues(alpha: 0.12),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 22, 152, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Super Sale',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.name ?? 'Premium Watch',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    // height: 1.10,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.displayPrice,
                  style: const TextStyle(
                    color: Color(0xFF8AF05B),
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8AF05B),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Text(
                    'Shop Now',
                    style: TextStyle(
                      color: Color(0xFF102013),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
