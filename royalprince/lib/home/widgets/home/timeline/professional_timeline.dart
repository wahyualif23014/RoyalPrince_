import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../models/experience_model.dart';
import 'experience_glass_card.dart';

class ProfessionalTimeline extends StatelessWidget {
  final List<ExperienceModel> data;

  const ProfessionalTimeline({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        color: Colors.grey.shade300,
        indicatorTheme: const IndicatorThemeData(
          position: 0,
          size: 24.0, // Sedikit diperbesar agar seimbang dengan glass card
        ),
        connectorTheme: const ConnectorThemeData(
          thickness: 2.5,
        ),
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: data.length,

        // 1. CONNECTOR (Garis)
        connectorBuilder: (_, index, ___) {
          return SolidLineConnector(
            color: data[index].color.withOpacity(0.3),
          );
        },

        // 2. INDICATOR (Titik)
        indicatorBuilder: (_, index) {
          return DotIndicator(
            color: data[index].color,
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 14.0,
            ),
          );
        },

        contentsBuilder: (context, index) {
          final item = data[index];
          final delay = Duration(milliseconds: 150 * index);

          return Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 24.0),
            // Menggunakan Widget Terpisah
            child: ExperienceGlassCard(item: item)
                .animate(delay: delay)
                .fadeIn(duration: 600.ms)
                .slideX(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
          );
        },
      ),
    );
  }
}