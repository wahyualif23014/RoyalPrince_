// lib/widgets/custom_header_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:motion/motion.dart';

class CustomHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onSeeMorePressed;

  const CustomHeaderWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onSeeMorePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Motion.elevated(
      elevation: 100,
      borderRadius: BorderRadius.circular(20.0), 
      child: Card(
        elevation: 50,
        shadowColor: Colors.black.withOpacity(0.40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          width: double.infinity,
          decoration: BoxDecoration( 
            borderRadius: BorderRadius.circular(20.0), 
            image: const DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1689714334494-ee2fad01f52f?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              ),
              fit: BoxFit.cover, 
              alignment: Alignment.center,
              colorFilter: ColorFilter.mode(
                Colors.black38, 
                BlendMode.darken,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Pastikan teks putih agar kontras
                ),
              )
              .animate()
              .fade(duration: 900.ms, curve: Curves.easeOut)
              .slideY(begin: 0.5, duration: 900.ms, curve: Curves.easeOut)
              .shimmer(
                colors: [
                  Colors.white.withOpacity(0.8), 
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.8),
                ],
                duration: 1800.ms,
              ),

              const SizedBox(height: 8),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white70, // Subtitle agak abu-abu agar kontras
                ),
              )
              .animate(delay: 300.ms)
              .fade(duration: 900.ms, curve: Curves.easeOut)
              .slideY(begin: 0.5, duration: 900.ms, curve: Curves.easeOut)
              .shimmer(
                colors: [
                  Colors.white.withOpacity(0.8),
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.8),
                ],
                duration: 1800.ms,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onSeeMorePressed,
                icon: const Icon(Icons.person_search_outlined, size: 18),
                label: const Text('See my profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ).animate().fade().slideY(begin: 0.8),
        ),
      ),
    );
  }
}