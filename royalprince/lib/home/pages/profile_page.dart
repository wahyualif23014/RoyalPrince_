// lib/pages/profile_page.dart

import 'package:flutter/material.dart';
// import '../widgets/profile_details_card.dart'; // Impor kartu profil Anda

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Agar menyatu dengan latar belakang utama
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          // child: ProfileDetailsCard(),
        ),
      ),
    );
  }
}