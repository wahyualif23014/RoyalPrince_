// lib/pages/home_page_content.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/image_model.dart';
import '../widgets/home/swipper/fan_carousel_widget.dart';
import '../widgets/header/custom_header_widget.dart';
import '../widgets/home/timeline/ProfileDetailsCard.dart';
import '../models/portfolio_model.dart';
import '../widgets/home/swipper/portfolio_swiper.dart';
import '../models/experience_model.dart';
import '../widgets/home/timeline/professional_timeline.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  bool _isProfileVisible = false;

  // --- CONSTANTS UNTUK JARAK ---
  static const double _sectionSpacing = 50.0;
  static const double _titleToContentSpacing = 20.0;

  // ============================================================
  //                       SECTION TITLE
  // ============================================================
  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: Colors.white, // putih agar terbaca di background gelap
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 5,
          width: 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.blueAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  // ============================================================
  //                      SECTION CONTAINER
  // ============================================================
  Widget _buildSectionContainer({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        const SizedBox(height: _titleToContentSpacing),
        child,
        const SizedBox(height: _sectionSpacing),
      ],
    );
  }

  // ============================================================
  //                         BACKGROUND
  // ============================================================
  Widget _buildBackground() {
    const String imageUrl =
        "https://images.unsplash.com/photo-1585314062340-f1a5a7c9328d?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.55), // efek gelap
            BlendMode.lighten,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.6),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  //                         MAIN BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // === Background Internet (Unsplash) ===
        Positioned.fill(child: _buildBackground()),

        // === Konten Halaman ===
        SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 50.0),
            children: [
              // HEADER
              CustomHeaderWidget(
                title: 'Welcome To My CV!',
                subtitle: 'This is a brief introduction about me.',
                onSeeMorePressed: () {
                  setState(() {
                    _isProfileVisible = !_isProfileVisible;
                  });
                },
              ),

              // PROFILE DETAILS
              AnimatedSize(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutBack,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _isProfileVisible ? 1.0 : 0.0,
                  child: _isProfileVisible
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: const ProfileDetailsCard(),
                        )
                      : const SizedBox.shrink(),
                ),
              ),

              const SizedBox(height: 40),

              // FEATURED PROJECTS
              _buildSectionContainer(
                title: 'Featured Projects',
                child: FanCarouselWidget(images: sampleImages),
              ),

              // PORTFOLIO
              _buildSectionContainer(
                title: 'Our Portfolio',
                child: SizedBox(
                  height: 280,
                  child: PortfolioSwiper(portfolioItems: dummyPortfolioItems),
                ),
              ),

              // EXPERIENCE
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Professional Experience'),
                  const SizedBox(height: _titleToContentSpacing),
                  ProfessionalTimeline(data: dummyExperiences),
                ],
              ),

              const SizedBox(height: 40),

              // FOOTER
              Center(
                child: Text(
                  "Thank you for visiting!",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
