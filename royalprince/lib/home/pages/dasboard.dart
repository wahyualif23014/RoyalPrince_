import 'package:flutter/material.dart';
import 'package:royalprince/home/widgets/portfolio_swiper.dart';
import '../widgets/portfolio_swiper.dart';
import '../models/portfolio_model.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Royalprince', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_arrow,
              progress: AlwaysStoppedAnimation(0.0),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: PortfolioSwiper(portfolioItems: dummyPortfolioItems),
    );
  }
}
