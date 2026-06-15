import 'package:flutter/material.dart';

class DarkMode {
  // Brand accents
  static const Color primary = Color(0xFF8AF05B); // Active pop lime green
  static const Color accent = Color(0xFF3B82F6);  // Royal blue

  // Exact UI Colors from the screenshot reference
  static const Color scaffold = Color(0xFF0B0E11);      // Deep midnight canvas background
  static const Color surface = Color(0xFF181C1F);       // Pill / Card fill background
  static const Color border = Color(0xFF2D3337);        // The clean subtle line stroke border
  
  // Text hierarchies matching your reference
  static const Color textPrimary = Color(0xFFEAEDEF);   // Crisp soft white
  static const Color textSecondary = Color(0xFF94999D); // Muted slate gray

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primary,
    scaffoldBackgroundColor: scaffold,
    
    colorScheme: ColorScheme.dark(
      primary: primary,
      onPrimary: const Color(0xFF0B0E11),
      secondary: accent,
      surface: scaffold,
      onSurface: textPrimary,
      surfaceContainerLow: surface,          // Used for container fills
      surfaceContainerHighest: border,       // Used specifically for borders
      onSurfaceVariant: textSecondary,
    ),
    
    appBarTheme: const AppBarTheme(
      backgroundColor: scaffold,
      foregroundColor: textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(color: textPrimary, fontSize: 20, fontWeight: FontWeight.w700),
      titleMedium: TextStyle(color: textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: textPrimary, fontSize: 14, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(color: textSecondary, fontSize: 13, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(color: textSecondary, fontSize: 11, fontWeight: FontWeight.w400),
    ),
  );
}