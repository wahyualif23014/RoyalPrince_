// lib/home/pages/project.dart
import 'package:flutter/material.dart';
import 'package:royalprince/home/widgets/project/medicine_classification_card.dart';
import 'package:royalprince/home/widgets/project/medicine_search_section.dart';
import 'package:royalprince/home/widgets/project/product_card.dart';
import '../models/project/product_model.dart'; // Import model

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Buat dummy product untuk contoh
    final dummyProduct = PharmacyProduct.dummy('1');

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const MedicineSearchSection(),
            ),
            const SizedBox(height: 20),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const MedicineClassificationCard(),
            ),

            const SizedBox(height: 32),

            // Usage Tips Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: PharmacyProductCard( // Perbaikan di sini
                product: dummyProduct, // Tambahkan parameter product
                onTap: () {
                  // Handle ketika card di-tap
                  _showProductDetail(context, dummyProduct);
                },
                onAddToCart: () {
                  // Handle ketika tambah ke keranjang
                  _addToCart(context, dummyProduct);
                },
                showFullDetails: false,
              ),
            ),
            const SizedBox(height: 80), // Extra padding for bottom navigation
          ]),
        ),
      ],
    );
  }

  // Helper function untuk menampilkan detail produk
  void _showProductDetail(BuildContext context, PharmacyProduct product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ProductDetailBottomSheet(product: product);
      },
    );
  }

  // Helper function untuk menambahkan ke keranjang
  void _addToCart(BuildContext context, PharmacyProduct product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} ditambahkan ke keranjang'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}