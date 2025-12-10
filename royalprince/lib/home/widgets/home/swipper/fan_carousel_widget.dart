// lib/widgets/fan_carousel_widget.dart

import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';

class FanCarouselWidget extends StatelessWidget {
  final List<String> images;

  const FanCarouselWidget({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FanCarouselImageSlider.sliderType1(
        imagesLink: images,
        isAssets: false,           
        autoPlay: true,            
        sliderHeight: 400,
        showIndicator: true,       
        indicatorActiveColor: Colors.blue, 
        indicatorDeactiveColor: Colors.grey,
      ),
    );
  }
}