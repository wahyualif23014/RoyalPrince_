// lib/pages/settings_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // State untuk mengelola status mode gelap
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Biarkan background transparan jika halaman ini bagian dari tampilan lain,
      // atau beri warna sesuai tema, contoh: Theme.of(context).scaffoldBackgroundColor
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView(
          children: [
            // Judul Halaman

            // Opsi Edit Profil
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Edit Profil'),
              subtitle: const Text('Ubah nama, foto, dan bio Anda'),
              onTap: () {
                // TODO: Navigasi ke halaman edit profil
              },
            ),

            // Opsi Notifikasi
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('Notifikasi'),
              subtitle: const Text('Atur notifikasi aplikasi'),
              onTap: () {
                // TODO: Navigasi ke halaman pengaturan notifikasi
              },
            ),

            // Opsi Tampilan
            ListTile(
              leading: const Icon(Icons.palette_outlined),
              title: const Text('Tampilan'),
              subtitle: const Text('Ubah tema dan warna aplikasi'),
              onTap: () {
                // TODO: Buka dialog atau halaman untuk memilih tema
              },
            ),
            ListTile(
              leading: const Icon(Icons.language_outlined),
              title: const Text('Bahasa'),
              subtitle: const Text('Pilih bahasa aplikasi'),
              onTap: () {},
            ),

            // Opsi Mode Gelap dengan Toggle
            SwitchListTile(
              secondary: const Icon(Icons.dark_mode_outlined),
              title: const Text('Mode Gelap'),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value;
                  // TODO: Tambahkan logika untuk mengubah tema aplikasi
                  // Anda bisa menggunakan Provider, Riverpod, atau GetX untuk ini
                });
              },
            ),

            const Divider(height: 32.0),

            // Opsi Info Aplikasi
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.blueAccent),
              title: const Text('Tentang Aplikasi'),
              onTap: () {
                // TODO: Tampilkan dialog "About" dengan info versi
              },
            ),

            // Opsi Logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('Keluar'),
              onTap: () {
                // 2. Panggil fungsi ini untuk keluar dari aplikasi
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
