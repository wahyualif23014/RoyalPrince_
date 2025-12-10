import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:royalprince/home/widgets/home/timeline/ProfileDetailsCard.dart';
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
  
  static const double _sectionSpacing = 40.0;
  static const double _titleToContentSpacing = 16.0;
  static const double _horizontalPadding = 16.0;
  static const double _bottomPadding = 80.0;

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 4,
          width: 60,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.orange, Colors.deepOrangeAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionContainer({
    required String title,
    required Widget child,
    bool withAnimation = true,
  }) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        const SizedBox(height: _titleToContentSpacing),
        child,
      ],
    );

    return withAnimation
        ? content.animate().fadeIn(duration: 500.ms).slideY(
            begin: 0.1,
            end: 0,
            curve: Curves.easeOutCubic,
          )
        : content;
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 1,
            color: Colors.white.withOpacity(0.2),
          ),
          const SizedBox(height: 16),
          Text(
            "Thank you for visiting my portfolio!",
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "© 2024 Royalprince. All rights reserved.",
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _isProfileVisible ? 1.0 : 0.0,
        child: _isProfileVisible
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: const ProfileDetailsCard()
                    .animate()
                    .fadeIn(duration: 300.ms)
                    .scale(
                      begin: const Offset(0.95, 0.95),
                      end: const Offset(1, 1),
                    ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          _horizontalPadding,
          16,
          _horizontalPadding,
          _bottomPadding,
        ),
        children: [
          CustomHeaderWidget(
            title: 'Welcome to My Portfolio',
            subtitle: 'Innovative solutions through creative development',
            onSeeMorePressed: () {
              setState(() {
                _isProfileVisible = !_isProfileVisible;
              });
            },
          )
              .animate()
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.2, end: 0),

          const SizedBox(height: 24),

          _buildProfileSection(),

          const SizedBox(height: _sectionSpacing),

          _buildSectionContainer(
            title: 'Featured Projects',
            child: FanCarouselWidget(images: sampleImages),
          ),

          const SizedBox(height: _sectionSpacing),

          _buildSectionContainer(
            title: 'Our Portfolio',
            child: SizedBox(
              height: 260,
              child: PortfolioSwiper(portfolioItems: dummyPortfolioItems),
            ),
          ),

          const SizedBox(height: _sectionSpacing),

          _buildSectionContainer(
            title: 'Professional Experience',
            child: ProfessionalTimeline(data: dummyExperiences),
          ),

          const SizedBox(height: _sectionSpacing),

          _buildFooter()
              .animate()
              .fadeIn(delay: 300.ms, duration: 500.ms),
        ],
      ),
    );
  }
}