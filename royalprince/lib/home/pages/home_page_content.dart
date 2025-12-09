// lib/pages/home_page_content.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/image_model.dart';
import '../widgets/fan_carousel_widget.dart';
import '../widgets/header/custom_header_widget.dart';
import '../widgets/ProfileDetailsCard.dart';
import '../models/portfolio_model.dart';
import '../widgets/portfolio_swiper.dart';
import '../models/experience_model.dart';
import '../widgets/professional_timeline.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  bool _isProfileVisible = false;

  // --- CONSTANTS UNTUK JARAK (Agar Konsisten) ---
  static const double _sectionSpacing = 50.0; // Jarak antar Section Besar
  static const double _titleToContentSpacing = 20.0; // Jarak Judul ke Isi

  // --- HELPER WIDGETS ---

  // 1. Widget Judul Section
  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24, // Sedikit diperbesar agar lebih tegas
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 5,
          width: 80, // Sedikit dipendekkan agar elegan
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.deepPurple, Colors.blueAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10), // Lebih bulat
          ),
        ),
      ],
    );
  }

  // 2. Wrapper Section (INI KUNCI SCALABILITY)
  // Gunakan ini untuk membungkus Judul + Isi Konten
  Widget _buildSectionContainer({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        const SizedBox(height: _titleToContentSpacing),
        child,
        const SizedBox(height: _sectionSpacing), // Jarak otomatis ke section bawahnya
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Padding horizontal tetap 16, tapi bawah dikasih 50 agar tidak mentok layar
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 50.0),
      children: [
        
        // --- HEADER SECTION ---
        CustomHeaderWidget(
          title: 'Welcome To My CV!',
          subtitle: 'This is a brief introduction about me.',
          onSeeMorePressed: () {
            setState(() {
              _isProfileVisible = !_isProfileVisible;
            });
          },
        ),

        // Animasi Profile Details
        AnimatedSize(
          duration: const Duration(milliseconds: 350), // Sedikit diperlambat biar smooth
          curve: Curves.easeOutBack, // Efek membal sedikit
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _isProfileVisible ? 1.0 : 0.0,
            child: _isProfileVisible
                ? Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                    child: const ProfileDetailsCard(),
                  )
                : const SizedBox.shrink(), // Gunakan shrink agar benar-benar hilang
          ),
        ),

        // Jarak Besar setelah Header sebelum masuk konten utama
        const SizedBox(height: 40), 

        // --- FEATURED PROJECTS ---
        // Menggunakan helper wrapper agar rapi
        _buildSectionContainer(
          title: 'Featured Projects',
          child: FanCarouselWidget(images: sampleImages),
        ),

        // --- PORTFOLIO ---
        _buildSectionContainer(
          title: 'Our Portfolio',
          child: SizedBox(
            height: 280, // Sedikit ditinggikan agar kartu punya ruang bernapas
            child: PortfolioSwiper(portfolioItems: dummyPortfolioItems),
          ),
        ),

        // --- EXPERIENCE ---
        // Disini kita tidak pakai _buildSectionContainer penuh karena Timeline punya padding sendiri
        // Tapi kita tetap pakai pola judul manual agar fleksibel
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Professional Experience'),
            const SizedBox(height: _titleToContentSpacing),
            ProfessionalTimeline(data: dummyExperiences),
          ],
        ),
        
        // --- (Opsional) Tambahan Footer atau Signature ---
        const SizedBox(height: 40),
        Center(
          child: Text(
            "Thank you for visiting!",
            style: TextStyle(
              color: Colors.grey.shade400,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}