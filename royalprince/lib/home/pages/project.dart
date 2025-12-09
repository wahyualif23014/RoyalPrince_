import 'package:flutter/material.dart';
import 'package:royalprince/home/widgets/project/featured_projects_section.dart';
import 'package:royalprince/home/widgets/project/featured_section.dart';
class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero, 
        children: [
          FeaturedProjectsSection(),

          FeaturedSection(),
        ],
      ),
    );
  }
}