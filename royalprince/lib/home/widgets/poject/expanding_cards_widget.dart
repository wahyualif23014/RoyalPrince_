// lib/widgets/expanding_cards_widget.dart

import 'package:flutter/material.dart';

// Widget utama yang menampung daftar kartu
class ExpandingCards extends StatefulWidget {
  final double height;
  final List<Map<String, dynamic>> items;

  const ExpandingCards({super.key, required this.height, required this.items});

  @override
  State<ExpandingCards> createState() => _ExpandingCardsState();
}

class _ExpandingCardsState extends State<ExpandingCards>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  void onExpand(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height, // Menggunakan tinggi dari parameter
      child: ListView.builder(
        itemCount: widget.items.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 56),
        addRepaintBoundaries: true,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: AnimatedCardItem(
              key: ValueKey(index),
              title: item['title'],
              subtitle: item['subtitle'],
              image: item['image'],
              icon: item['icon'] as IconData,
              iconColor: item['color'] as Color,
              isExpanded: _selectedIndex == index,
              animation: _controller,
              onTap: () => onExpand(_selectedIndex == index ? -1 : index),
            ),
          );
        },
      ),
    );
  }
}

// Widget untuk satu item kartu yang bisa beranimasi
class AnimatedCardItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  final IconData icon;
  final Animation<double> animation;
  final bool isExpanded;
  final VoidCallback onTap;
  final Color iconColor;

  const AnimatedCardItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.icon,
    required this.animation,
    required this.isExpanded,
    required this.onTap,
    required this.iconColor,
  });

  @override
  State<AnimatedCardItem> createState() => _AnimatedCardItemState();
}

class _AnimatedCardItemState extends State<AnimatedCardItem> {
  bool shouldRect = false;

  @override
  void didUpdateWidget(covariant AnimatedCardItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      shouldRect = true;
    } else {
      shouldRect = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    const double collapsedWidth = 70;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedBuilder(
            animation: widget.animation,
            builder: (context, child) {
              // ... (SEMUA KODE ANIMASI DARI KODE ASLI)
              // Tidak ada yang perlu diubah di sini
              double value =
                  shouldRect
                      ? widget.isExpanded
                          ? widget.animation.value
                          : 1 - widget.animation.value
                      : widget.isExpanded
                      ? 1
                      : 0;

              final double animValue =
                  widget.isExpanded
                      ? const Interval(
                        0,
                        0.5,
                        curve: Curves.fastOutSlowIn,
                      ).transform(value)
                      : Interval(
                        0.5,
                        1,
                        curve: Curves.fastOutSlowIn.flipped,
                      ).transform(value);

              final imageScaleValue =
                  widget.isExpanded
                      ? const Interval(
                        0.2,
                        1,
                        curve: Curves.easeOut,
                      ).transform(value)
                      : const Interval(
                        0.8,
                        1,
                        curve: Curves.easeOut,
                      ).transform(value);

              final titleValue =
                  widget.isExpanded
                      ? const Interval(
                        0.2,
                        0.8,
                        curve: Curves.easeOut,
                      ).transform(value)
                      : const Interval(
                        0.2,
                        0.8,
                        curve: Curves.easeOut,
                      ).transform(value);

              final subtitleValue =
                  widget.isExpanded
                      ? const Interval(
                        0.4,
                        0.8,
                        curve: Curves.easeOut,
                      ).transform(value)
                      : const Interval(
                        0.4,
                        0.8,
                        curve: Curves.easeOut,
                      ).transform(value);

              return Transform.scale(
                scale: 1 + animValue * 0.02,
                child: Container(
                  width: collapsedWidth + animValue * (300 - collapsedWidth),
                  height: 200 + (animValue * 20),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(collapsedWidth / 2),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Transform.scale(
                          scale: 1.2 - imageScaleValue * 0.03,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(widget.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                            foregroundDecoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0),
                                  Colors.black.withOpacity(1),
                                ],
                                stops: const [0.7, 1],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10 + animValue * 10,
                            vertical: 10 + animValue * 12,
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: SizedBox.square(
                                  dimension: 50,
                                  child: Center(
                                    child: Icon(
                                      widget.icon,
                                      color: widget.iconColor,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              if (widget.isExpanded)
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Opacity(
                                          opacity: titleValue,
                                          child: Transform.translate(
                                            offset: Offset(
                                              20 * (1 - titleValue),
                                              0,
                                            ),
                                            child: Text(
                                              widget.title,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Opacity(
                                          opacity: subtitleValue,
                                          child: Transform.translate(
                                            offset: Offset(
                                              20 * (1 - subtitleValue),
                                              0,
                                            ),
                                            child: Text(
                                              widget.subtitle,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
