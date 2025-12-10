import 'dart:ui';
import 'package:flutter/material.dart';

class GlassBaseContainer extends StatelessWidget {
  final bool isHovered;
  final bool isPressed;
  final Widget child;

  const GlassBaseContainer({
    super.key,
    required this.isHovered,
    required this.isPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 200);
    const curve = Curves.easeOutCubic;
    final borderRadius = BorderRadius.circular(20);

    // --- Kalkulasi Visual ---
    final double scale = isPressed ? 0.98 : (isHovered ? 1.02 : 1.0);
    
    final List<Color> gradientColors = isHovered
        ? [Colors.white.withOpacity(0.6), Colors.white.withOpacity(0.15)]
        : [Colors.white.withOpacity(0.4), Colors.white.withOpacity(0.1)];

    final Color borderColor = isHovered
        ? Colors.white.withOpacity(0.9)
        : Colors.white.withOpacity(0.5);

    final BoxShadow shadow = isHovered
        ? BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 24,
            offset: const Offset(0, 12),
          )
        : BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          );

    return AnimatedScale(
      scale: scale,
      duration: duration,
      curve: curve,
      child: AnimatedContainer(
        duration: duration,
        curve: curve,
        // Margin penting agar shadow tidak terpotong saat hover
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: [shadow],
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Stack(
            children: [
              // Layer 1: Blur (Backdrop)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: const SizedBox.expand(),
              ),

              // Layer 2: Gradient, Border & Content Surface
              AnimatedContainer(
                duration: duration,
                curve: curve,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  border: Border.all(color: borderColor, width: 1.2),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors,
                    stops: const [0.1, 1.0],
                  ),
                ),
                child: child, // Isi konten dirender di sini
              ),

              // Layer 3: Shine Effect (Pojok Kiri Atas)
              Positioned(
                top: -30,
                left: -30,
                child: AnimatedOpacity(
                  opacity: isHovered ? 1.0 : 0.6,
                  duration: duration,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}