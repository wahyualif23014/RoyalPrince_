// lib/main.dart

import 'package:flutter/material.dart';
import 'package:motion/motion.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <-- 1. IMPORT
import './home/pages/dasboard.dart'; // <-- 2. IMPORT DASHBOARD
import './home/pages/onboarding_screen.dart'; // <-- 3. IMPORT ONBOARDING

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi package motion Anda
  await Motion.instance.initialize();
  Motion.instance.setUpdateInterval(60.fps);

  // 4. Periksa status onboarding
  final prefs = await SharedPreferences.getInstance();
  // Ambil nilai boolean. Jika tidak ada, anggap false (belum selesai).
  final bool showHome = prefs.getBool('onboarding_complete') ?? false;

  runApp(MyApp(showHome: showHome)); // <-- 5. Kirim status ke MyApp
}

class MyApp extends StatelessWidget {
  // 6. Terima status dari main()
  final bool showHome;
  const MyApp({super.key, required this.showHome});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Royalprince',
      // 7. Tentukan halaman awal secara dinamis
      home: showHome ? const DashboardPage() : const OnBoardingPage(),
    );
  }
}