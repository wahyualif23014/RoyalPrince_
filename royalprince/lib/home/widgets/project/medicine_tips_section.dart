// lib/home/widgets/project/medicine_tips_section.dart
import 'package:flutter/material.dart';
import '../../models/project/medicine_model.dart';

class MedicineTipsSection extends StatelessWidget {
  final List<MedicineTip> tips;

  const MedicineTipsSection({
    super.key,
    this.tips = const [],
  });

  @override
  Widget build(BuildContext context) {
    final List<MedicineTip> displayTips = 
        tips.isEmpty ? medicineTips : tips;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const(title: 'Tips Penggunaan Obat'),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: displayTips.length,
          itemBuilder: (context, index) {
            final tip = displayTips[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    tip.icon,
                    color: Colors.orange,
                    size: 24,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    tip.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tip.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}