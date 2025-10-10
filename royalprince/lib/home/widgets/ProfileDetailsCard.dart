// lib/widgets/profile_details_card.dart

import 'package:flutter/material.dart';

class ProfileDetailsCard extends StatelessWidget {
  const ProfileDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black.withOpacity(0.8),
      color: Colors.white30,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Bagian Header Profil ---
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32'), // Ganti dengan URL foto Anda
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 16),
            const Text(
              'Wahyu alif ajir nurdianto', // Ganti dengan nama Anda
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Flutter Developer & UI/UX Enthusiast', // Ganti dengan profesi Anda
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueAccent[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            const Divider(height: 40, thickness: 1),

            // --- Bagian Info Kontak ---
            const InfoTile(
              icon: Icons.email_outlined,
              text: 'zexvulca@gmail.com', // Ganti dengan email
            ),
            const SizedBox(height: 12),
            const InfoTile(
              icon: Icons.phone_outlined,
              text: '+62 87740041124', // Ganti dengan nomor telepon
            ),
            const SizedBox(height: 12),
            const InfoTile(
              icon: Icons.location_on_outlined,
              text: 'Madura, Indonesia', // Ganti dengan lokasi
            ),

            const SizedBox(height: 24),

            // --- Bagian Statistik/Info Tambahan ---
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatItem(count: '128', label: 'Projects'),
                StatItem(count: '5.2K', label: 'Followers'),
                StatItem(count: '4.8', label: 'Rating'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget kecil untuk item info (Email, Telepon, dll.)
class InfoTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoTile({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600]),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}


// Widget kecil untuk item statistik (Projects, Followers, dll.)
class StatItem extends StatelessWidget {
  final String count;
  final String label;

  const StatItem({super.key, required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}