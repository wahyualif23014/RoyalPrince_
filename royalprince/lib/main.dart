// lib/main.dart

import 'package:flutter/material.dart';
import 'package:motion/motion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './home/pages/dasboard.dart'; 
import './home/pages/onboarding_screen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi package motion Anda
  await Motion.instance.initialize();
  Motion.instance.setUpdateInterval(60.fps);

  final prefs = await SharedPreferences.getInstance();
  final bool showHome = prefs.getBool('onboarding_complete') ?? false;

  runApp(MyApp(showHome: showHome)); 
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({super.key, required this.showHome});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Royalprince',
      home: showHome ? const DashboardPage() : const OnBoardingPage(),
    );
  }
}