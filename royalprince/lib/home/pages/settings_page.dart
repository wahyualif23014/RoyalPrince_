// lib/pages/settings_page.dart

import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false; // Contoh state untuk toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 16.0, top: 8.0),
              child: Text(
                'Pengaturan',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Edit Profil'),
              subtitle: const Text('Ubah nama, foto, dan info Anda'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('Notifikasi'),
              subtitle: const Text('Atur notifikasi aplikasi'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.palette_outlined),
              title: const Text('Tampilan'),
              subtitle: const Text('Ubah tema dan warna aplikasi'),
              onTap: () {},
            ),
            // Contoh setting dengan toggle
            SwitchListTile(
              secondary: const Icon(Icons.dark_mode_outlined),
              title: const Text('Mode Gelap'),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.blueAccent),
              title: const Text('Tentang Aplikasi'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}