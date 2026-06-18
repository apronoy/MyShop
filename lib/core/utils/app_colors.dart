import 'package:flutter/material.dart';

/// Centralized color palette for the app inspired by the provided
/// premium fashion / e‑commerce screenshot.
///
/// Design goals:
/// - Deep Emerald Green primary (luxury / fashion)
/// - Warm Cream background for an upscale paper-like canvas
/// - Soft Beige surfaces for cards and panels
/// - Elegant Gold/Orange accents for CTAs and highlights
/// - High-contrast typography for readability
class AppColors {
  // Primary greens (brand)
  // Deep Emerald: used for AppBar, primary buttons, active icons
  static const Color primary = Color(0xFF0B473C); // Deep Emerald Green
  static const Color primaryVariant = Color(
    0xFF06352D,
  ); // Darker emerald for elevation
  static const Color secondary = Color(
    0xFF285A51,
  ); // Supporting green for accents

  // Backgrounds
  // Warm cream base as in screenshot
  static const Color background = Color(0xFFF7EFE5); // Warm Cream Background
  static const Color surface = Color(
    0xFFFFF8F1,
  ); // Soft Beige surface for cards
  static const Color card = Color(
    0xFFF2E7D9,
  ); // Slightly warmer card background

  // Accent (gold / orange)
  static const Color accent = Color(
    0xFFD36E0D,
  ); // Elegant Gold / Orange - primary accent
  static const Color accentLight = Color(
    0xFFEB8E11,
  ); // Lighter accent for hover states

  // Text
  static const Color textPrimary = Color(
    0xFF0B473C,
  ); // High contrast, same as primary for headings
  static const Color textSecondary = Color(
    0xFF4D645F,
  ); // Subheadings, less emphasis
  static const Color textDisabled = Color(
    0xFFBFB5AE,
  ); // Disabled/placeholder text

  // Borders / Dividers
  static const Color border = Color(0xFFD7D2CA);
  static const Color divider = Color(0xFFE5DDD2);

  // Feedback
  static const Color success = Color(0xFF2E7D32); // Material green 700
  static const Color warning = Color(0xFFF59E0B); // Amber-ish warning
  static const Color error = Color(0xFFD32F2F); // Material red 700

  // Utility
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF121212);
}

/// Provides themed Material `ThemeData` tuned for a premium light UI.
class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      secondary: AppColors.accent,
      background: AppColors.background,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      error: AppColors.error,
    ),

    // AppBar: deep emerald with white text (luxury header)
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: AppColors.white),
    ),

    // Bottom nav: surface with active accent
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      showUnselectedLabels: true,
    ),

    // Elevated buttons use the accent for high visibility
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.primary),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.white,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.card,
      selectedColor: AppColors.primary,
      labelStyle: const TextStyle(color: AppColors.textPrimary),
      secondaryLabelStyle: const TextStyle(color: AppColors.white),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      pressElevation: 0,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white.withOpacity(0.0),
      hintStyle: const TextStyle(color: AppColors.textSecondary),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    ),

    dividerColor: AppColors.divider,
    disabledColor: AppColors.textDisabled,

    // Progress indicators (loading) use the accent color for visibility
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.accent,
    ),

    // Icon theme
    iconTheme: const IconThemeData(color: AppColors.textSecondary),

    // Typography defaults tuned for contrast
  );
}
