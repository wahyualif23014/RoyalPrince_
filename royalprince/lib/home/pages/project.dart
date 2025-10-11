import 'package:flutter/material.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.work_outline, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Halaman Proyek',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('Tampilkan portofolio proyek Anda di sini.'),
        ],
      ),
    );
  }
}