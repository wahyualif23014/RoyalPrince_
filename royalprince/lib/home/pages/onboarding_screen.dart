// lib/pages/onboarding_screen.dart

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import './dasboard.dart'; 

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  // <-- PERUBAHAN 3: Fungsi _onIntroEnd dimodifikasi
  void _onIntroEnd(BuildContext context) async {
    // Simpan penanda bahwa onboarding sudah selesai
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);

    // Navigasi ke DashboardPage, bukan lagi HomePage
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const DashboardPage()),
    );
  }

  /// Widget helper untuk membangun animasi Lottie dari URL.
  Widget _buildLottie(String url) {
    return Center(
      child: Lottie.network(
        url,
        width: 300,
        height: 300,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Bagian ini tidak ada perubahan
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 19.0),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.only(top: 60),
      imageFlex: 3,
      bodyFlex: 2,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "Selamat Datang!",
          body: "Ini adalah CV digital saya. Kenali saya lebih dalam melalui aplikasi ini.",
          image: _buildLottie('https://lottie.host/55d7c588-dc2d-470c-9590-412fefb9ffe0/I86sTMDj8w.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Jelajahi Portofolio",
          body: "Lihat berbagai proyek yang pernah saya kerjakan di bagian portofolio.",
          image: _buildLottie('https://lottie.host/6a470c2e-a685-4a6d-b2b8-b2b344a6f8eb/xSC9qC6Y1I.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Siap Terhubung?",
          body: "Jika Anda tertarik, jangan ragu untuk melihat profil lengkap dan menghubungi saya. Mari mulai!",
          image: _buildLottie('https://lottie.host/3456eade-03cf-43c6-86d8-22566c36a1e8/lQjS6frlva.json'),
          decoration: pageDecoration,
        ),
      ],
      // Kedua tombol ini sekarang memanggil fungsi _onIntroEnd yang sudah diperbarui
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      showNextButton: true,
      showBackButton: false,
      skip: const Text('Lewati', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Mulai', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}