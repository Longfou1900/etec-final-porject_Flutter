import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/model/onboarding_item.dart';
import 'package:flutter_projects_getx/feature/view/screen/onborading/widgets/onboarding_page_style.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;
  final OnboardingPageStyle style;

  const OnboardingPage({
    super.key,
    required this.item,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(54, 108, 54, 156),
        child: Column(
          children: [
            _PageLabel(label: style.label),
            Expanded(
              child: _HeroImage(
                imagePath: item.imagePath,
                icon: style.icon,
                shadowColor: style.shadow,
              ),
            ),
            _PageText(
              title: item.title,
              description: item.description,
            ),
          ],
        ),
      ),
    );
  }
}

class _PageLabel extends StatelessWidget {
  final String label;

  const _PageLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: const Color(0xFF272735).withValues(alpha: 0.36),
        fontSize: 11,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.4,
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  final String imagePath;
  final IconData icon;
  final Color shadowColor;

  const _HeroImage({
    required this.imagePath,
    required this.icon,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest.shortestSide.clamp(220.0, 310.0);

          return SizedBox.square(
            dimension: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: size * 0.76,
                  height: size * 0.76,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.9),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor.withValues(alpha: 0.18),
                        blurRadius: 30,
                        offset: const Offset(0, 18),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      icon,
                      size: 82,
                      color: const Color(0xFF272735),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PageText extends StatelessWidget {
  final String title;
  final String description;

  const _PageText({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF272735),
            fontSize: 24,
            fontWeight: FontWeight.w900,
            height: 1.06,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF272735).withValues(alpha: 0.62),
            fontSize: 13,
            fontWeight: FontWeight.w600,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}
