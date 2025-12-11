// lib/home/widgets/project/medicine_classification_card.dart
import 'package:flutter/material.dart';
import '../../models/project/medicine_model.dart';

class MedicineClassificationCard extends StatefulWidget {
  final List<MedicineCategory> categories;
  final ValueChanged<MedicineCategory>? onCategoryTap;

  const MedicineClassificationCard({
    super.key,
    this.categories = const [],
    this.onCategoryTap,
  });

  @override
  State<MedicineClassificationCard> createState() =>
      _MedicineClassificationCardState();
}

class _MedicineClassificationCardState
    extends State<MedicineClassificationCard> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<MedicineCategory> displayCategories =
        widget.categories.isEmpty ? medicineCategories : widget.categories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _buildHeroCarousel(displayCategories),
        const SizedBox(height: 16),
        _buildPageIndicator(displayCategories.length),
      ],
    );
  }

  // Widget untuk hero carousel yang lebih responsif
  Widget _buildHeroCarousel(List<MedicineCategory> categories) {
    return SizedBox(
      height: 250, // Lebih tinggi untuk efek hero
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return _buildHeroCard(context, categories[index], index);
        },
      ),
    );
  }

  Widget _buildHeroCard(
    BuildContext context,
    MedicineCategory category,
    int index,
  ) {
    final bool isCenter = index == _currentPage;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(
        horizontal: isCenter ? 4 : 12,
        vertical: isCenter ? 0 : 16,
      ),
      transform:
          Matrix4.identity()
            ..scale(isCenter ? 1.0 : 0.92)
            ..translate(0.0, isCenter ? 0.0 : 8.0),
      child: Card(
        elevation: isCenter ? 8 : 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: Color.fromRGBO(40, 40, 40, 0.95),
        child: InkWell(
          onTap: () => _showCategoryDetails(context, category),
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Header dengan icon dan badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(
                          category.color.red,
                          category.color.green,
                          category.color.blue,
                          0.2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow:
                            isCenter
                                ? [
                                  BoxShadow(
                                    color: category.color.withOpacity(0.3),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ]
                                : null,
                      ),
                      child: Icon(
                        category.icon,
                        color: category.color,
                        size: 22,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Title dengan efek scaling
                AnimatedScale(
                  scale: isCenter ? 1.05 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    category.title,
                    style: TextStyle(
                      fontSize: isCenter ? 22 : 20,
                      fontWeight: FontWeight.w700,
                      color: category.color,
                      height: 1.2,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Description dengan efek fade
                Expanded(
                  child: AnimatedOpacity(
                    opacity: isCenter ? 1.0 : 0.8,
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      category.description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        height: 1.5,
                      ),
                      maxLines: isCenter ? 4 : 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Progress bar dengan animasi
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         // LABEL 0

                //       ],
                //     ),
                //     const SizedBox(height: 8),
                //     Container(
                //       height: 6,
                //       decoration: BoxDecoration(
                //         color: Color.fromRGBO(255, 255, 255, 0.1),
                //         borderRadius: BorderRadius.circular(3),
                //       ),
                //       child: AnimatedFractionallySizedBox(
                //         duration: const Duration(milliseconds: 500),
                //         curve: Curves.easeOut,
                //         alignment: Alignment.centerLeft,
                //         widthFactor: isCenter ? 0.7 : 0.5,
                //         child: Container(
                //           decoration: BoxDecoration(
                //             color: category.color,
                //             borderRadius: BorderRadius.circular(3),
                //             gradient: LinearGradient(
                //               colors: [
                //                 category.color,
                //                 category.color.withOpacity(0.8),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                // const SizedBox(height: 10),

                // Footer dengan contoh dan arrow
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contoh:',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color.fromRGBO(255, 255, 255, 0.6),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          category.examples.first,
                          style: TextStyle(
                            fontSize: 14,
                            color: category.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    // Animated arrow button
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isCenter ? 44 : 40,
                      height: isCenter ? 44 : 40,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(
                          category.color.red,
                          category.color.green,
                          category.color.blue,
                          0.2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow:
                            isCenter
                                ? [
                                  BoxShadow(
                                    color: category.color.withOpacity(0.2),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ]
                                : null,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: category.color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Page indicator untuk carousel
  Widget _buildPageIndicator(int itemCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color:
                _currentPage == index
                    ? medicineCategories.isNotEmpty
                        ? medicineCategories[index % medicineCategories.length]
                            .color
                        : Colors.blue
                    : Color.fromRGBO(255, 255, 255, 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  // Widget untuk detail kategori
  void _showCategoryDetails(BuildContext context, MedicineCategory category) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return _buildBottomSheet(context, category);
      },
    );
  }

  Widget _buildBottomSheet(BuildContext context, MedicineCategory category) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1a1a1a),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: category.color.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              // Drag Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 6,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header dengan glow effect
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(
                            category.color.red,
                            category.color.green,
                            category.color.blue,
                            0.1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromRGBO(
                              category.color.red,
                              category.color.green,
                              category.color.blue,
                              0.3,
                            ),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(
                                  category.color.red,
                                  category.color.green,
                                  category.color.blue,
                                  0.2,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: category.color.withOpacity(0.2),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Icon(
                                category.icon,
                                color: category.color,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                category.title,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: category.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Description section
                      const Text(
                        'Deskripsi:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        category.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(255, 255, 255, 0.8),
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Examples section
                      const Text(
                        'Contoh Obat:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Examples list dengan card
                      ...category.examples.map((example) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Color.fromRGBO(255, 255, 255, 0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.medical_services_outlined,
                                color: category.color,
                                size: 20,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  example,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Icon(Icons.chevron_right, color: category.color),
                            ],
                          ),
                        );
                      }).toList(),

                      const SizedBox(height: 32),

                      // Close button dengan efek
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(
                              category.color.red,
                              category.color.green,
                              category.color.blue,
                              0.2,
                            ),
                            foregroundColor: category.color,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: Color.fromRGBO(
                                  category.color.red,
                                  category.color.green,
                                  category.color.blue,
                                  0.4,
                                ),
                                width: 2,
                              ),
                            ),
                            elevation: 4,
                          ),
                          child: const Text(
                            'Tutup',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
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
        );
      },
    );
  }
}
