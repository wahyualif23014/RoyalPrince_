// lib/home/widgets/project/medicine_search_section.dart
import 'package:flutter/material.dart';
import '../../models/project/medicine_model.dart';

class MedicineSearchSection extends StatelessWidget {
  final List<MedicineFilter> filters;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onFilterSelected;

  const MedicineSearchSection({
    super.key,
    this.filters = const [],
    this.onSearchChanged,
    this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<MedicineFilter> displayFilters = 
        filters.isEmpty ? medicineFilters : filters;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const _SectionTitle(title: 'Cari Obat'),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Masukkan nama obat atau gejala...',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white.withOpacity(0.7),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.filter_list,
                  color: Colors.white.withOpacity(0.7),
                ),
                onPressed: () {},
              ),
            ),
            onChanged: onSearchChanged,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: displayFilters.map((filter) {
            return _MedicineFilterChip(
              filter: filter,
              onSelected: onFilterSelected,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _MedicineFilterChip extends StatelessWidget {
  final MedicineFilter filter;
  final ValueChanged<String>? onSelected;

  const _MedicineFilterChip({
    required this.filter,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        filter.label,
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
      backgroundColor: Colors.orange.withOpacity(0.2),
      side: BorderSide(color: Colors.orange.withOpacity(0.3)),
      // onSelected: (_) => onSelected?.call(filter.id),
    );
  }
}