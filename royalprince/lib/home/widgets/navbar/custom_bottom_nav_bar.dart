import 'package:flutter/material.dart';
import 'package:royalprince/themes/bnb_custom_painter.dart';


class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
    return Container(
      width: size.width,
      height: 80,
      color: Colors.transparent, // Background transparan
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: BNBCustomePainter(),
          ),
          
          Positioned(
            left: size.width / 2 - 30, // Posisi tepat di tengah
            top: -20,
            child: FloatingActionButton(
              onPressed: () => onTap(4),
              backgroundColor: Colors.orange,
              elevation: 8,
              child: const Icon(
                Icons.account_circle_rounded,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
          
          Container(
            width: size.width,
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildNavItem(Icons.home, 0, size),
                    SizedBox(width: size.width * 0.1),
                    _buildNavItem(Icons.work_outline, 1, size),
                  ],
                ),
                
                SizedBox(width: 60), // Lebar sesuai dengan FAB
                
                Row(
                  children: [
                    _buildNavItem(Icons.contact_mail, 2, size),
                    SizedBox(width: size.width * 0.1),
                    _buildNavItem(Icons.settings, 3, size),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Membangun item navigasi individual
  Widget _buildNavItem(IconData icon, int index, Size size) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: currentIndex == index ? Colors.orange : Colors.white,
          ),
          const SizedBox(height: 4),
          // Indicator aktif
          if (currentIndex == index)
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}