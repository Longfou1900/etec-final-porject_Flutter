import 'package:flutter/material.dart';

class AppTheme{
  static const primaryColor = Color(0xFF00A896);
  static const sencondaryColor = Color(0xFF028090);
  static const backgroundColor = Color(0xFFF8F9FA);
  static const darkTextColor = Color(0xFF2BD42);
  static const dangerColor = Color(0xFFEF233C); // Admin Delete Buttons

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'Roboto', // Supports smooth Khmer fonts if configured in pubspec
      textTheme: const TextTheme(
        headlineMedium: TextStyle(color: darkTextColor, fontSize: 20, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: darkTextColor, fontSize: 16),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}