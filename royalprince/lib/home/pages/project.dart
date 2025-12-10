// lib/home/pages/project.dart
import 'package:flutter/material.dart';
import 'package:royalprince/home/widgets/project/medicine_classification_card.dart';
import 'package:royalprince/home/widgets/project/medicine_search_section.dart';
import 'package:royalprince/home/widgets/project/medicine_tips_section.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              // Project Section 1
              // Container(
              //   margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              //   // child: const FeaturedProjectsSection(),
              // ),
              
              // const SizedBox(height: 32),
              
              // // Project Section 2
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 16),
              //   // child: const FeaturedSection(),
              // ),
              
              // const SizedBox(height: 32),
              
              // // Medicine Classification Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: const MedicineClassificationCard(),
              ),
              
              const SizedBox(height: 32),
              
              // Medicine Search Section
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 16),
              //   child: const MedicineSearchSection(),
              // ),
              
              const SizedBox(height: 32),
              
              // Usage Tips Section
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 16),
              //   child: const MedicineTipsSection(),
              // ),
              
              const SizedBox(height: 80), // Extra padding for bottom navigation
            ],
          ),
        ),
      ],
    );
  }
}