import 'package:flutter/material.dart';

class ExperienceModel {
  final String title;       // Contoh: Senior Flutter Dev
  final String company;     // Contoh: Google / Tokopedia
  final String description; // Penjelasan pekerjaan
  final String date;        // Contoh: 2023 - Present
  final Color color;        // Warna tema item ini

  ExperienceModel({
    required this.title,
    required this.company,
    required this.description,
    required this.date,
    required this.color,
  });
}

// --- DATA CONTOH (Langsung taruh sini agar mudah dipanggil) ---
final List<ExperienceModel> dummyExperiences = [
  ExperienceModel(
    title: "Senior App Developer",
    company: "Tech Unicorn Inc.",
    description: "Memimpin tim beranggotakan 5 orang, menerapkan Clean Architecture, dan meningkatkan performa aplikasi sebesar 40%.",
    date: "2023 - Present",
    color: const Color(0xFF2196F3), // Biru
  ),
  ExperienceModel(
    title: "UI/UX Designer",
    company: "Creative Studio",
    description: "Merancang antarmuka pengguna yang intuitif menggunakan Figma dan melakukan A/B Testing.",
    date: "2021 - 2023",
    color: const Color(0xFFE91E63), // Pink
  ),
  ExperienceModel(
    title: "Junior Flutter Dev",
    company: "StartUp Maju",
    description: "Belajar fundamental Dart, state management (Bloc/GetX), dan integrasi API.",
    date: "2019 - 2021",
    color: const Color(0xFFFF9800), // Orange
  ),
];