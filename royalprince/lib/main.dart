// lib/main.dart

import 'package:flutter/material.dart';
import 'package:motion/motion.dart';
import 'home/pages/dasboard.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Motion.instance.initialize(); 
  Motion.instance.setUpdateInterval(60.fps);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Aplikasi Royalprince',
      home: DashboardPage(), // <-- 3. Arahkan ke layar Dashboard
    );
  }
}