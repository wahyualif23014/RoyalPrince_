import 'package:flutter/material.dart';
import 'package:royalprince/home/pages/about.dart';
import 'package:royalprince/home/pages/project.dart';
import '../widgets/custom_bottom_nav_bar.dart'; 
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

  final List<Widget> _pages = [
    const HomePageContent(), 
    const ProjectsPage(), // Indeks 1
    const ContactPage(), // Indeks 3
    const SettingsPage(),
    const AboutPage(),
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
          // IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
