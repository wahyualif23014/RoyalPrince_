import 'package:flutter/material.dart';
import 'package:royalprince/home/pages/about.dart';
import 'package:royalprince/home/pages/project.dart';
import '../widgets/navbar/custom_bottom_nav_bar.dart'; 
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
    const ProjectsPage(),
    const ContactPage(),
    const SettingsPage(),
    const AboutPage(),
  ];

  final List<String> _pageTitles = [
    'Royalprince',
    'Projects',
    'Contact',
    'Settings',
    'About Me',
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      
      backgroundColor: Colors.transparent,
      
      appBar: AppBar(
        title: Text(
          _pageTitles[_currentIndex],
          style: const TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold, 
            color: Colors.white
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0a0a0a),
                Color(0xFF1a1a1a),
                Color(0xFF2d2d2d),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF000000),
              Color(0xFF0a0a0a),
              Color(0xFF1a1a1a),
              Color(0xFF2d2d2d),
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: IndexedStack(
          index: _currentIndex, 
          children: _pages
        ),
      ),
      
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
        ),
      ),
    );
  }
}