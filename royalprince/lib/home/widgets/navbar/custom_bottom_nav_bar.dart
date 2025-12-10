// lib/widgets/custom_bottom_nav_bar.dart

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
      // width: size.width,
      // height: 80,
      // color: Colors.transparent, 
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: BNBCustomePainter(),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              onPressed: () => onTap(4), // Indeks untuk keranjang
              backgroundColor: Colors.orange,
              elevation: 0.1,
              child: const Icon(Icons.account_circle_rounded, size: 30, color: Colors.black),
            ),
          ),
          SizedBox(
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(Icons.home, 0),
                _buildNavItem(Icons.work_outline, 1),
                SizedBox(width: size.width * .20),
                _buildNavItem(Icons.contact_mail, 2),
                _buildNavItem(Icons.settings, 3),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Helper widget untuk membuat setiap item navigasi
  Widget _buildNavItem(IconData icon, int index, {Color? color}) {
    return IconButton(
      onPressed: () => onTap(index),
      icon: Icon(
        icon,
        color: currentIndex == index ? Colors.orange : (Colors.white),
      ),
    );
  }
}