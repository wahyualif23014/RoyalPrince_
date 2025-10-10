// lib/main.dart

import 'package:flutter/material.dart';
import 'home/pages/dasboard.dart'; // <-- 1. Impor file dashboard.dart

void main() {
  runApp(const MyApp()); // <-- 2. Jalankan widget utama aplikasi
}

// Widget utama ini berfungsi sebagai "akar" dari aplikasi Anda
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp adalah widget inti yang membungkus seluruh aplikasi
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner "Debug"
      title: 'Aplikasi Royalprince',
      // 'home' menentukan widget/layar apa yang pertama kali ditampilkan
      home: Dashboard(), // <-- 3. Arahkan ke layar Dashboard
    );
  }
}