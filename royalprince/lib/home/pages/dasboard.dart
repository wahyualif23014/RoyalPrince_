// lib/pages/dashboard.dart

import 'package:flutter/material.dart';
// Pastikan path import ini benar sesuai struktur folder Anda
import 'package:royalprince/home/models/portfolio_model.dart'; 
import 'package:royalprince/home/widgets/portfolio_swiper.dart';
import '../models/image_model.dart';
import '../widgets/fan_carousel_widget.dart';
import '../widgets/custom_header_widget.dart'; 

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Royalprince', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black, // Agar icon dan title terlihat jelas
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Fungsi untuk notifikasi
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Fungsi untuk menu
            },
          ),
        ],
      ),
      body: SingleChildScrollView( // Widget ini sudah benar, membuat seluruh konten bisa di-scroll
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- Bagian Header ---
              const CustomHeaderWidget(
                title: 'Welcome My CV!',
                subtitle: 'This is a brief introduction.',
              ),
              
              const SizedBox(height: 24),
              const SizedBox(height: 24),

              // --- Widget FanCarousel ---
              FanCarouselWidget(images: sampleImages),

              const SizedBox(height: 32), // Beri jarak lebih agar tidak terlalu rapat

              // --- Bagian "Other Sections" ---
              const Text(
                'Our Portfolio', // Judul lebih deskriptif
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // --- OPTIMALISASI DI SINI ---
              // Beri batasan tinggi yang pasti untuk PortfolioSwiper.
              // Column memerlukan ukuran pasti dari children-nya.
              // Dengan SizedBox, Anda memberi tahu Column "sisihkan 250 pixel untuk widget ini".
              SizedBox(
                height: 250, // Atur tinggi sesuai desain Anda
                child: PortfolioSwiper(portfolioItems: dummyPortfolioItems),
              ),
              
              const SizedBox(height: 24), // Jarak di akhir konten
            ],
          ),
        ),
      ),
    );
  }
}