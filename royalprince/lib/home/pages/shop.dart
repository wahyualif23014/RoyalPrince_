import 'package:flutter/material.dart';
import 'package:royalprince/home/widgets/project/medicine_classification_card.dart';
import 'package:royalprince/home/widgets/project/medicine_search_section.dart';
import 'package:royalprince/home/widgets/project/product_card.dart';
import '../models/project/product_model.dart';
import '../../services/api_service.dart'; // Pastikan import service ini ada

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  // Variable untuk menyimpan Future request
  late Future<List<PharmacyProduct>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  // Method untuk memanggil API
  void _fetchProducts() {
    setState(() {
      _productsFuture = ApiService.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Tambahkan background color jika perlu agar glassmorphism terlihat
      backgroundColor: const Color(0xFF1E1E1E), 
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                
                // --- 1. SEARCH SECTION ---
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: _glassDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      decoration: _innerGlassDecoration(),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: MedicineSearchSection(),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // --- 2. CLASSIFICATION CARD ---
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: _glassDecoration(blurRadius: 25, offset: const Offset(0, 10)),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                          width: 1,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.05),
                            Colors.transparent,
                            Colors.white.withOpacity(0.02),
                          ],
                        ),
                      ),
                      child: const ClipRRect(
                        child: MedicineClassificationCard(),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // --- 3. SECTION TITLE ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Produk Rekomendasi',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.5,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 3,
                        width: 60,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.blueAccent, Colors.purpleAccent],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),

                // --- 4. PRODUCT LIST (FROM API) ---
                FutureBuilder<List<PharmacyProduct>>(
                  future: _productsFuture,
                  builder: (context, snapshot) {
                    // A. STATE LOADING
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                       child: CircularProgressIndicator(
                          color: Colors.blueAccent,
                        ),
                      );
                    }

                    // B. STATE ERROR
                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          children: [
                            const Icon(Icons.error_outline, color: Colors.redAccent, size: 40),
                            const SizedBox(height: 10),
                            Text(
                              'Gagal memuat data',
                              style: TextStyle(color: Colors.white.withOpacity(0.7)),
                            ),
                            TextButton(
                              onPressed: _fetchProducts,
                              child: const Text('Coba Lagi'),
                            )
                          ],
                        ),
                      );
                    }

                    // C. STATE EMPTY
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Text(
                            'Belum ada produk tersedia.',
                            style: TextStyle(color: Colors.white.withOpacity(0.5)),
                          ),
                        ),
                      );
                    }

                    // D. STATE SUCCESS (DATA ADA)
                    final products = snapshot.data!;
                    
                    return ListView.separated(
                      // Agar tidak conflict dengan CustomScrollView
                      shrinkWrap: true, 
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: _glassDecoration(blurRadius: 30, offset: const Offset(0, 12)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
                              decoration: _innerGlassDecoration(width: 1.5),
                              child: PharmacyProductCard(
                                product: product,
                                onTap: () => _showProductDetail(context, product),
                                onAddToCart: () => _addToCart(context, product),
                                showFullDetails: false,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // --- REUSABLE DECORATIONS ---

  BoxDecoration _glassDecoration({double blurRadius = 20, Offset offset = const Offset(0, 8)}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: blurRadius,
          offset: offset,
          spreadRadius: -2,
        ),
      ],
    );
  }

  BoxDecoration _innerGlassDecoration({double width = 1}) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.08),
          Colors.white.withOpacity(0.04),
        ],
      ),
      border: Border.all(
        color: Colors.white.withOpacity(0.1),
        width: width,
      ),
    );
  }

  // --- HELPER FUNCTIONS ---

  void _showProductDetail(BuildContext context, PharmacyProduct product) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Detail: ${product.name}"))
    );
  }

  void _addToCart(BuildContext context, PharmacyProduct product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.greenAccent, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${product.name} ditambahkan ke keranjang',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF1a1a1a),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        elevation: 8,
      ),
    );
  }
}