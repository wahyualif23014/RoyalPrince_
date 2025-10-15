import 'package:flutter/material.dart';
import 'package:royalprince/home/widgets/poject/featured_projects_section.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero, 
        children: [
          FeaturedProjectsSection(),
        ],
      ),
    );
  }
}