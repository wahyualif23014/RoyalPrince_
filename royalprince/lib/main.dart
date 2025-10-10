// lib/main.dart

import 'package:flutter/material.dart';
import 'package:motion/motion.dart';
import 'home/pages/dasboard.dart'; // <-- 1. Impor file dashboard.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Motion.instance.initialize(); // <-- Tambahkan ini
  Motion.instance.setUpdateInterval(60.fps); // <-- Tambahkan ini
  runApp(const MyApp());
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