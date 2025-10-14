// lib/pages/home_page_content.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/image_model.dart';
import '../widgets/fan_carousel_widget.dart'; 
import '../widgets/custom_header_widget.dart'; 
import '../widgets/ProfileDetailsCard.dart'; 
import '../models/portfolio_model.dart'; 
import '../widgets/portfolio_swiper.dart'; 

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  bool _isProfileVisible = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        CustomHeaderWidget(
          title: 'Welcome To My CV!',
          subtitle: 'This is a brief introduction about me.',
          onSeeMorePressed: () {
            setState(() {
              _isProfileVisible = !_isProfileVisible;
            });
          },
        ),

        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: _isProfileVisible ? 1.0 : 0.0,
            child: _isProfileVisible
                ? const Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: ProfileDetailsCard(),
                  )
                : const SizedBox(height: 0), 
          ),
        ),

        const SizedBox(height: 24),
        FanCarouselWidget(images: sampleImages),
        const SizedBox(height: 32),
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
    );
  }
}