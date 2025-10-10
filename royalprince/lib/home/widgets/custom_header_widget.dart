// lib/widgets/custom_header_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:motion/motion.dart'; // <<< 1. Tambahkan import untuk package motion

class CustomHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomHeaderWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // <<< 2. Bungkus Card dengan Motion.elevated
    return Motion.elevated(
      elevation: 100, // Atur seberapa besar efek 3D yang diinginkan
      borderRadius: BorderRadius.circular(15.0),
      child: Card(
        // Properti Card tetap sama, tanpa animasi
        color: Colors.white,
        elevation: 50, // Elevation ini tetap ada untuk tampilan awal
        shadowColor: Colors.black.withOpacity(0.10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // <<< ANIMASI PADA TITLE (TETAP SAMA)
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              )
              .animate()
              .fade(duration: 900.ms, curve: Curves.easeOut)
              .slideY(begin: 0.5, duration: 900.ms, curve: Curves.easeOut)
              .shimmer(
                colors: [
                  const Color(0xFFFFFF),
                  const Color(0xFFE0E0E0),
                  const Color(0xFFFFFF),
                ],
                duration: 1800.ms,
              ),

              const SizedBox(height: 8),

              // <<< ANIMASI PADA SUBTITLE (TETAP SAMA)
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              )
              .animate(delay: 300.ms)
              .fade(duration: 900.ms, curve: Curves.easeOut)
              .slideY(begin: 0.5, duration: 900.ms, curve: Curves.easeOut)
              .shimmer(
                colors: [
                  const Color(0xFFFFFF),
                  const Color(0xFFE0E0E0),
                  const Color(0xFFFFFF),
                ],
                duration: 1800.ms,
              ),
            ],
          ),
        ),
      ),
    );
  }
}