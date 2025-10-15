// lib/widgets/featured_projects_section.dart

import 'package:flutter/material.dart';
import './expanding_cards_widget.dart'; // Impor widget ExpandingCards

class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key});

  // Data untuk ExpandingCards dipindahkan ke sini
  final List<Map<String, dynamic>> featuredProjectItems = const [
    {
      'title': 'Aplikasi Mobile Banking',
      'subtitle': 'Dibuat dengan Flutter & Firebase',
      'image':
          'https://images.unsplash.com/photo-1557804506-669a67965ba0?q=80&w=2874&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'icon': Icons.phone_android,
      'color': Color(0xFF5D9CEC),
    },
    {
      'title': 'Website E-Commerce',
      'subtitle': 'Dibangun dengan React & Node.js',
      'image':
          'https://images.unsplash.com/photo-1522199755839-a2bacb67c546?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'icon': Icons.web,
      'color': Color(0xFF2ECC71),
    },
    {
      'title': 'Website E-Commerce',
      'subtitle': 'Dibangun dengan React & Node.js',
      'image':
          'https://images.unsplash.com/photo-1522199755839-a2bacb67c546?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'icon': Icons.web,
      'color': Color(0xFF2ECC71),
    },
    {
      'title': 'Website E-Commerce',
      'subtitle': 'Dibangun dengan React & Node.js',
      'image':
          'https://images.unsplash.com/photo-1522199755839-a2bacb67c546?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'icon': Icons.web,
      'color': Color(0xFF2ECC71),
    },
    {
      'title': 'Desain UI/UX Aplikasi',
      'subtitle': 'Didesain menggunakan Figma',
      'image':
          'https://images.unsplash.com/photo-1559028006-448665bd7c24?q=80&w=2881&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'icon': Icons.design_services,
      'color': Color(0xFFED5565),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Widget ExpandingCards untuk Proyek Unggulan
        ExpandingCards(height: 400, items: featuredProjectItems),
      ],
    );
  }
}
