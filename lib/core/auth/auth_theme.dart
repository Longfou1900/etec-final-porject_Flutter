import 'package:flutter/material.dart';

abstract class AuthTheme {
  // Clean / ultra-modern palette (soft neutral + subtle accent)
  static const Color primary = Color(0xFF2F6BFF); // calmer blue
  static const Color primaryDark = Color(0xFF1B4EDB);

  static const Color background = Color(0xFFF7F8FF);
  static const Color surface = Colors.white;

  static const Color inputBorder = Color(0xFFE7E9F5);
  static const Color inputFocusBorder = primary;

  static const Color textPrimary = Color(0xFF111827); // slate-900-ish
  static const Color textSecondary = Color(0xFF6B7280); // gray-500-ish
  static const Color divider = Color(0xFFE5E7F0);

  static const Color googleRed = Color(0xFFEA4335);

  static const Gradient headerGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient buttonGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static BoxDecoration get gradientButtonDecoration => BoxDecoration(
        gradient: buttonGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.26),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      );

  static InputDecoration inputDecoration({
    required String hint,
    required IconData prefixIcon,
    Widget? suffix,
  }) =>
      InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: textSecondary, fontSize: 15),
        prefixIcon: Icon(prefixIcon, color: primary, size: 20),
        suffixIcon: suffix,
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: inputBorder, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: inputFocusBorder, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      );
}
