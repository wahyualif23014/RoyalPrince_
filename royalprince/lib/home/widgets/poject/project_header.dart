// lib/widgets/project_header.dart

import 'package:flutter/material.dart';

class ProjectHeader extends StatelessWidget {
  final String title;

  const ProjectHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}