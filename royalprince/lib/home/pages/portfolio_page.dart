// lib/pages/portfolio_page.dart

import 'package:flutter/material.dart';
import '../models/image_model.dart'; // Sesuaikan path
import '../widgets/fan_carousel_widget.dart';
import '../models/portfolio_model.dart'; // Sesuaikan path
import '../widgets/portfolio_swiper.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Latar belakang yang sedikit berbeda
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Featured Projects',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'A collection of my best works and showcases.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            
            // Tampilkan FanCarousel di sini
            FanCarouselWidget(
              images: sampleImages, 
              // sliderHeight: 350, // Mungkin sedikit lebih kecil di halaman ini
              // autoPlay: true,
            ),

            const SizedBox(height: 40),

            const Text(
              'All Works',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Tampilkan PortfolioSwiper di sini
            SizedBox(
              height: 250,
              child: PortfolioSwiper(portfolioItems: dummyPortfolioItems),
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}