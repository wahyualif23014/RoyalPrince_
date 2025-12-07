import 'package:flutter/material.dart';

class FeaturedSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Dignity',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '24 Photos',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Gallery grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 1.0, // Square images
            ),
            itemCount: 6, // Display 6 images (2 rows of 3)
            itemBuilder: (context, index) {
              return ProjectImageItem(index: index);
            },
          ),

          // "Get full Page" button
          const SizedBox(height: 16.0),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.teal,
                border: Border.all(color: Colors.deepPurple[300]!),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'Get full Page',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectImageItem extends StatelessWidget {
  final int index;

  const ProjectImageItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    // For demo purposes, using different colors for each image
    // Replace with actual image loading logic
    List<Color> demoColors = [
      Colors.blue[100]!,
      Colors.green[100]!,
      Colors.orange[100]!,
      Colors.purple[100]!,
      Colors.red[100]!,
      Colors.teal[100]!,
    ];

    return Container(
      decoration: BoxDecoration(
        color: demoColors[index % demoColors.length],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Placeholder for image - replace with Image.network() or Image.asset()
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: demoColors[index % demoColors.length],
            ),
          ),
          
          // Number badge overlay (optional)
          if (index == 0) // Show only on first image as example
            Positioned(
              top: 8.0,
              right: 8.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}