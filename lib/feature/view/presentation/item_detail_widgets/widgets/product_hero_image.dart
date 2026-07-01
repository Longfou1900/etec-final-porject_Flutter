import 'package:flutter/material.dart';

class ProductHeroImage extends StatefulWidget {
  final String heroTag;
  final String? imageUrl;

  /// Accepts list of images to support carousel.
  final List<String>? images;

  const ProductHeroImage({
    super.key,
    required this.heroTag,
    this.imageUrl,
    this.images,
  });

  @override
  State<ProductHeroImage> createState() => _ProductHeroImageState();
}

class _ProductHeroImageState extends State<ProductHeroImage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final safeImages = (widget.images ?? const <String>[])
        .where((e) => e.isNotEmpty)
        .toList();
    final listToShow = safeImages.isNotEmpty
        ? safeImages
        : (widget.imageUrl != null && widget.imageUrl!.isNotEmpty
            ? [widget.imageUrl!]
            : <String>[]);

    return Hero(
      tag: widget.heroTag,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: listToShow.isEmpty
              ? Icon(
                  Icons.watch_rounded,
                  size: 110,
                  color: scheme.onSurfaceVariant.withValues(alpha: 0.3),
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: listToShow.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final url = listToShow[index];
                        return Center(
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.78,
                            height: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.network(
                                url,
                                fit: BoxFit.contain,
                                alignment: Alignment.center,
                                errorBuilder: (_, __, ___) => Icon(
                                  Icons.watch_rounded,
                                  size: 110,
                                  color: scheme.onSurfaceVariant
                                      .withValues(alpha: 0.3),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      width: 90,
                      child: Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            final current =
                                (_pageController.page ?? 0).round();
                            final prev = current - 1;
                            if (prev >= 0) {
                              _pageController.animateToPage(
                                prev,
                                duration:
                                    const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Material(
                            color: scheme.surfaceContainerLow
                                .withOpacity(0.75),
                            shape: const CircleBorder(),
                            child: const Padding(
                              padding: EdgeInsets.all(14),
                              child: Icon(
                                Icons.chevron_left_rounded,
                                size: 26,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Right arrow
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      width: 90,
                      child: Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            final current =
                                (_pageController.page ?? 0).round();
                            final next = current + 1;
                            if (next < listToShow.length) {
                              _pageController.animateToPage(
                                next,
                                duration:
                                    const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Material(
                            color: scheme.surfaceContainerLow
                                .withOpacity(0.75),
                            shape: const CircleBorder(),
                            child: const Padding(
                              padding: EdgeInsets.all(14),
                              child: Icon(
                                Icons.chevron_right_rounded,
                                size: 26,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

