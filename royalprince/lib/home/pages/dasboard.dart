import 'package:flutter/material.dart';
import 'package:royalprince/home/pages/about.dart';
import 'package:royalprince/home/pages/project.dart';
import '../widgets/custom_bottom_nav_bar.dart'; // Sesuaikan path jika perlu
import 'home_page_content.dart';
import 'settings_page.dart';
import 'contact_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  // 1. Sesuaikan daftar halaman sesuai jumlah tombol navigasi (5 tombol)
  final List<Widget> _pages = [
    const HomePageContent(), // Indeks 0
    const ProjectsPage(), // Indeks 1
    const ContactPage(), // Indeks 3
    const SettingsPage(),
    const AboutPage(), // Indeks 2 (Sekarang halaman biasa)
    // Indeks 4
  ];

  // Sesuaikan juga judulnya
  final List<String> _pageTitles = [
    'Royalprince',
    'Projects',
    'Contact',
    'Settings',
    'About Me',
  ];

  // 2. Hapus logika _onTap yang rumit. Buat fungsi yang simpel.
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pageTitles[_currentIndex],
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavBar(
        // 3. Kirimkan _currentIndex secara langsung, tanpa pemetaan.
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
