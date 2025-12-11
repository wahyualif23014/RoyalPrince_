// lib/home/widgets/project/medicine_search_section.dart
import 'package:flutter/material.dart';

class MedicineSearchSection extends StatefulWidget {
  final ValueChanged<String>? onSearchChanged;
  final String? initialQuery;
  final String? hintText;
  final EdgeInsetsGeometry? margin;

  const MedicineSearchSection({
    super.key,
    this.onSearchChanged,
    this.initialQuery,
    this.hintText,
    this.margin,
  });

  @override
  State<MedicineSearchSection> createState() => _MedicineSearchSectionState();
}

class _MedicineSearchSectionState extends State<MedicineSearchSection> {
  late TextEditingController _searchController;
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.symmetric(horizontal: 16),
      child: _buildSearchBar(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: _hasFocus 
            ? Colors.black.withOpacity(0.4)
            : Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _hasFocus 
              ? Colors.white.withOpacity(0.3)
              : Colors.white.withOpacity(0.1),
          width: _hasFocus ? 1.5 : 1,
        ),
        boxShadow: _hasFocus
            ? [
                BoxShadow(
                  color: Colors.white.withOpacity(0.05),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText ?? 'Cari nama obat..',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 15,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: _hasFocus 
                ? Colors.white.withOpacity(0.9)
                : Colors.white.withOpacity(0.7),
            size: 24,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? _buildClearButton()
              : null,
        ),
        onChanged: (value) {
          widget.onSearchChanged?.call(value);
        },
        onTap: () {
          // Optional: Handle tap if needed
        },
        onSubmitted: (value) {
          // Optional: Handle search submission
          widget.onSearchChanged?.call(value);
        },
        textInputAction: TextInputAction.search,
      ),
    );
  }

  Widget _buildClearButton() {
    return IconButton(
      icon: Icon(
        Icons.clear,
        color: Colors.white.withOpacity(0.7),
        size: 20,
      ),
      onPressed: () {
        _searchController.clear();
        widget.onSearchChanged?.call('');
        _focusNode.unfocus();
      },
      splashRadius: 20,
    );
  }
}