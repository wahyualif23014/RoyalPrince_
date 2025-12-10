// lib/home/widgets/project/medicine_classification_card.dart
import 'package:flutter/material.dart';
import '../../models/project/medicine_model.dart';

class MedicineClassificationCard extends StatelessWidget {
  final List<MedicineCategory> categories;
  final ValueChanged<MedicineCategory>? onCategoryTap;

  const MedicineClassificationCard({
    super.key,
    this.categories = const [],
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<MedicineCategory> displayCategories = 
        categories.isEmpty ? medicineCategories : categories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        _buildCategoriesGrid(context, displayCategories),
      ],
    );
  }

    

  Widget _buildCategoriesGrid(BuildContext context, List<MedicineCategory> categories) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.95,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return _buildCategoryCard(context, categories[index]);
      },
    );
  }

  Widget _buildCategoryCard(BuildContext context, MedicineCategory category) {
    return InkWell(
      onTap: () => _showCategoryDetails(context, category),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: category.color.withOpacity(0.2),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon and Title
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: category.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    category.icon,
                    color: category.color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    category.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: category.color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Description
            Text(
              category.description,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const Spacer(),
            
            // Examples (simplified)
            Text(
              'Contoh: ${category.examples.first}',
              style: TextStyle(
                fontSize: 11,
                color: category.color.withOpacity(0.8),
                fontStyle: FontStyle.italic,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            // View More Text
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Selengkapnya',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.orange.withOpacity(0.8),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 10,
                  color: Colors.orange.withOpacity(0.8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
          decoration: const BoxDecoration(
            color: Color(0xFF1a1a1a),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Drag Handle
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: category.color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            category.icon,
                            color: category.color,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            category.title,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: category.color,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white70),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Description
                    Text(
                      category.description,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Examples Section
                    const Text(
                      'Contoh Obat:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Examples List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: category.examples.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              Icon(
                                Icons.medical_services_outlined,
                                size: 16,
                                color: category.color,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                category.examples[index],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Close Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: category.color.withOpacity(0.15),
                          foregroundColor: category.color,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: category.color.withOpacity(0.3)),
                          ),
                        ),
                        child: const Text('Tutup'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}