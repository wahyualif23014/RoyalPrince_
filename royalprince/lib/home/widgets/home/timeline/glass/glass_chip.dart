import 'package:flutter/material.dart';

class GlassChip extends StatelessWidget {
  final String text;
  final Color color;

  const GlassChip({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color.withOpacity(1.0),
          fontWeight: FontWeight.w700,
          fontSize: 12,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}