import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int total;
  final int current;

  const PageIndicator({
    super.key,
    required this.total,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (index) {
        final isActive = index == current;

        return AnimatedContainer(
          width: isActive ? 18 : 7,
          height: 7,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFF272735)
                : const Color(0xFFE3E5F2),
            borderRadius: BorderRadius.circular(7),
          ),
        );
      }),
    );
  }
}
