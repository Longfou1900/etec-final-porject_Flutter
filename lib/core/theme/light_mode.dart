import 'package:flutter/material.dart';

class LightMode {
  // Brand accents matching your design system
  static const Color primary = Color(0xFF1A1D1F);    // Crisp, deep charcoal/black for primary actions and titles
  static const Color accent = Color(0xFF8AF05B);     // Your signature active vibrant lime pop
  static const Color linkColor = Color(0xFF2563EB);  // Electric blue reserved cleanly for ratings/links

  // Premium Alabaster Light System (Clean, airy, and minimal)
  static const Color scaffold = Color(0xFFF5F7F8);   // Soft premium grey/white canvas background
  static const Color surface = Color(0xFFFFFFFF);    // Pure crisp white for cards and layout elements
  static const Color border = Color(0xFFE8ECEF);     // Thin hairline border layout lines
  
  // High-contrast, elegant typography colors
  static const Color textPrimary = Color(0xFF1A1D1F);   // Deep obsidian black
  static const Color textSecondary = Color(0xFF6F767E); // Soft refined neutral grey

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primary,
    scaffoldBackgroundColor: scaffold,
    
    // Perfectly mapped material tokens matching your custom dark-slate logic
    colorScheme: ColorScheme.light(
      primary: primary,
      onPrimary: Colors.white,
      secondary: linkColor, // Ratings and blue highlight tags map here
      onSecondary: Colors.white,
      surface: scaffold,
      onSurface: textPrimary,
      surfaceContainerLow: surface,          // Used for the modern rounded product pill fills
      surfaceContainerHighest: border,       // The exact thin border line mapping
      onSurfaceVariant: textSecondary,
    ),
    
    appBarTheme: const AppBarTheme(
      backgroundColor: scaffold,
      foregroundColor: textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0, // Maintains a flat header profile when contents scroll underneath
    ),
    
    // Configured transparently to allow your floating capsule nav bar to display neatly
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: primary,
      unselectedItemColor: textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
  );
}