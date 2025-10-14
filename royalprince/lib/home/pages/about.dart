import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_outline, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Halaman Tentang Saya',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('Ceritakan tentang diri Anda di sini.'),
        ],
      ),
    );
  }
}