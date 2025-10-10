// lib/pages/dashboard.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // <-- Pastikan ini diimpor untuk animasi
import '../models/image_model.dart';
import '../widgets/fan_carousel_widget.dart';
import '../widgets/custom_header_widget.dart';
import '../widgets/ProfileDetailsCard.dart'; 
import 'package:royalprince/home/models/portfolio_model.dart'; // Sesuaikan path jika perlu
import 'package:royalprince/home/widgets/portfolio_swiper.dart'; // Sesuaikan path jika perlu

// 1. UBAH MENJADI STATEFULWIDGET
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _isProfileVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Royalprince', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- Bagian Header ---
              CustomHeaderWidget(
                title: 'Welcome To My CV!',
                subtitle: 'This is a brief introduction about me.',
                // 3. HUBUNGKAN TOMBOL DENGAN STATE
                onSeeMorePressed: () {
                  setState(() {
                    _isProfileVisible = !_isProfileVisible; // Toggle visibilitas
                  });
                },
              ),

              // 4. MUNCULKAN KARTU PROFIL DENGAN ANIMASI
              if (_isProfileVisible)
                Padding(
                  padding: const EdgeInsets.only(top: 30.0), // Jarak dari header
                  child: const ProfileDetailsCard(),
                )
                .animate()
                .fadeIn(duration: 500.ms)
                .slideY(begin: -0.3, end: 0, duration: 600.ms, curve: Curves.easeOutCubic)
                .slideX(begin: -0.3, end: 0, duration: 600.ms, curve: Curves.easeOutCubic),

              const SizedBox(height: 24),

              // --- Widget FanCarousel ---
              FanCarouselWidget(images: sampleImages),

              const SizedBox(height: 32),

              // --- Bagian "Other Sections" ---
              const Text(
                'Our Portfolio',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              SizedBox(
                height: 250,
                child: PortfolioSwiper(portfolioItems: dummyPortfolioItems),
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}