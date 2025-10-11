// lib/widgets/custom_animated_navbar.dart

import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:royalprince/colors/custom_colors_theme.dart';

class CustomAnimatedNavBar extends StatelessWidget {
  final List<IconData> iconList;
  final List<String> iconLabelList; // Tambahkan ini untuk menerima label
  final int activeIndex;
  final Function(int) onTap;
  final Animation<double> notchAndCornersAnimation;
  final AnimationController hideAnimationController;
  final AutoSizeGroup autoSizeGroup;

  const CustomAnimatedNavBar({
    Key? key,
    required this.iconList,
    required this.iconLabelList, // Tambahkan di constructor
    required this.activeIndex,
    required this.onTap,
    required this.notchAndCornersAnimation,
    required this.hideAnimationController,
    required this.autoSizeGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColorsTheme>()!;

    return AnimatedBottomNavigationBar.builder(
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        final color = isActive
            ? colors.activeNavigationBarColor
            : colors.notActiveNavigationBarColor;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconList[index],
              size: 24,
              color: color,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4), // Padding disesuaikan
              child: AutoSizeText(
                iconLabelList[index], // Gunakan label dari list
                maxLines: 1,
                minFontSize: 10, // Atur ukuran font minimum
                style: TextStyle(color: color),
                group: autoSizeGroup,
              ),
            )
          ],
        );
      },
      // ... properti lainnya tetap sama
      backgroundColor: colors.bottomNavigationBarBackgroundColor,
      activeIndex: activeIndex,
      onTap: onTap,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      hideAnimationController: hideAnimationController,
      notchAndCornersAnimation: notchAndCornersAnimation,
      shadow: BoxShadow(
        offset: const Offset(0, -1),
        blurRadius: 12,
        spreadRadius: 0.5,
        color: colors.activeNavigationBarColor.withOpacity(0.3),
      ),
    );
  }
}