import 'package:flutter/material.dart';

class OnboardingPageStyle {
  final Color shapeColor;
  final Color accent;
  final Color shadow;
  final IconData icon;
  final String label;

  const OnboardingPageStyle({
    required this.shapeColor,
    required this.accent,
    required this.shadow,
    required this.icon,
    required this.label,
  });

  static const _styles = [
    OnboardingPageStyle(
      shapeColor: Color.fromARGB(255, 3, 118, 156),
      accent: Color(0xFF28C7C9),
      shadow: Color(0xFFFFA06F),
      icon: Icons.watch_rounded,
      label: 'BUSINESS',
    ),
    OnboardingPageStyle(
      shapeColor: Color.fromARGB(255, 3, 118, 156),
      accent: Color(0xFF28C7C9),
      shadow: Color.fromARGB(255, 3, 118, 156),
      icon: Icons.forum_rounded,
      label: 'COMMUNITY',
    ),
    OnboardingPageStyle(
      shapeColor: Color.fromARGB(255, 3, 118, 156),
      accent: Color(0xFFFF8A3D),
      shadow: Color(0xFFFFA06F),
      icon: Icons.lightbulb_rounded,
      label: 'PLAN',
    ),
  ];

  static OnboardingPageStyle at(int index) => _styles[index % _styles.length];
}
