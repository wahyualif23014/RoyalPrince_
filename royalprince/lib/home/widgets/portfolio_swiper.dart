// lib/widgets/portfolio_swiper.dart

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../models/portfolio_model.dart'; 
import 'portfolio_card.dart';           

class PortfolioSwiper extends StatelessWidget {
  final List<PortfolioItems> portfolioItems;

  const PortfolioSwiper({
    super.key,
    required this.portfolioItems,
  });

  @override
  Widget build(BuildContext context) {
    if (portfolioItems.isEmpty) {
      return const Center(child: Text("Tidak ada portofolio."));
    }

    return CardSwiper(
      cardsCount: portfolioItems.length,
      numberOfCardsDisplayed: 4,
      backCardOffset: const Offset(25, 30,),
      padding: const EdgeInsets.all(24.0),
      cardBuilder: (
        context,
        index,
        percentThresholdX,
        percentThresholdY,
      ) {
        final item = portfolioItems[index];
        return PortfolioCard(item: item);
      },
    );
  }
}