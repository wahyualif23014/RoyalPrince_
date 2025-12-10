import 'package:flutter/material.dart';
import '../../../models/experience_model.dart';
import 'glass/glass_base_container.dart';
import 'experience_card_content.dart';

class ExperienceGlassCard extends StatefulWidget {
  final ExperienceModel item;
  final VoidCallback? onTap;

  const ExperienceGlassCard({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  State<ExperienceGlassCard> createState() => _ExperienceGlassCardState();
}

class _ExperienceGlassCardState extends State<ExperienceGlassCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      // Logika Hover
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      
      child: GestureDetector(
        // Logika Tap / Klik
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        
        child: GlassBaseContainer(
          isHovered: _isHovered,
          isPressed: _isPressed,
          child: ExperienceCardContent(item: widget.item),
        ),
      ),
    );
  }
}