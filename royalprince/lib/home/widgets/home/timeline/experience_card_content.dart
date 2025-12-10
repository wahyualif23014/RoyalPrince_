import 'package:flutter/material.dart';
import '../../../models/experience_model.dart';
import 'glass/glass_chip.dart'; // Import Chip yang dibuat di atas

class ExperienceCardContent extends StatelessWidget {
  final ExperienceModel item;

  const ExperienceCardContent({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GlassChip(text: item.date, color: item.color),
            const SizedBox(width: 12),
            Expanded(
              child: _CompanyBadge(company: item.company),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Title
        Text(
          item.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
            letterSpacing: -0.5,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        
        // Description
        Text(
          item.description,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white60,
            height: 1.6,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _CompanyBadge extends StatelessWidget {
  final String company;

  const _CompanyBadge({required this.company});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(Icons.business_rounded, size: 16, color: Colors.white60),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            company,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
              letterSpacing: 0.2,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}