// lib/theme/app_theme.dart

import 'package:flutter/material.dart';
import '../colors/custom_colors_theme.dart'; 

class AppTheme {
  // Tema untuk mode terang
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      useMaterial3: true,
      
      // Di sinilah kita mendaftarkan palet warna kustom "Sage & Ash"
      extensions: const <ThemeExtension<dynamic>>[
        CustomColorsTheme.sageAndAsh,
      ],
    );
  }

  // Anda juga bisa mendefinisikan tema gelap di sini nanti
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blueAccent,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      
      // Anda bisa membuat palet warna custom yang berbeda untuk mode gelap
      extensions: const <ThemeExtension<dynamic>>[
        CustomColorsTheme.sageAndAsh, // Untuk saat ini kita pakai yang sama
      ],
    );
  }
}