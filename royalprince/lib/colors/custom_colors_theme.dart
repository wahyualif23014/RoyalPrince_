// lib/theme/custom_colors_theme.dart

import 'package:flutter/material.dart';

@immutable
class CustomColorsTheme extends ThemeExtension<CustomColorsTheme> {
  const CustomColorsTheme({
    required this.activeNavigationBarColor,
    required this.notActiveNavigationBarColor,
    required this.bottomNavigationBarBackgroundColor,
  });

  final Color activeNavigationBarColor;
  final Color notActiveNavigationBarColor;
  final Color bottomNavigationBarBackgroundColor;

  // Mendefinisikan palet warna "Sage & Ash"
  static const sageAndAsh = CustomColorsTheme(
    bottomNavigationBarBackgroundColor: Color(0xFFF8F8F8), // Off-White
    activeNavigationBarColor: Color(0xFF8A9A5B), // Sage Green
    notActiveNavigationBarColor: Color(0xFFB0B8B0), // Ash Grey
  );

  @override
  CustomColorsTheme copyWith({
    Color? activeNavigationBarColor,
    Color? notActiveNavigationBarColor,
    Color? bottomNavigationBarBackgroundColor,
  }) {
    return CustomColorsTheme(
      activeNavigationBarColor:
          activeNavigationBarColor ?? this.activeNavigationBarColor,
      notActiveNavigationBarColor:
          notActiveNavigationBarColor ?? this.notActiveNavigationBarColor,
      bottomNavigationBarBackgroundColor: bottomNavigationBarBackgroundColor ??
          this.bottomNavigationBarBackgroundColor,
    );
  }

  @override
  CustomColorsTheme lerp(ThemeExtension<CustomColorsTheme>? other, double t) {
    if (other is! CustomColorsTheme) {
      return this;
    }
    return CustomColorsTheme(
      activeNavigationBarColor: Color.lerp(
          activeNavigationBarColor, other.activeNavigationBarColor, t)!,
      notActiveNavigationBarColor: Color.lerp(
          notActiveNavigationBarColor, other.notActiveNavigationBarColor, t)!,
      bottomNavigationBarBackgroundColor: Color.lerp(
          bottomNavigationBarBackgroundColor,
          other.bottomNavigationBarBackgroundColor,
          t)!,
    );
  }
}