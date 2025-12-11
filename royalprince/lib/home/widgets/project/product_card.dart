// lib/home/widgets/shop/product_card.dart
import 'package:flutter/material.dart';
import '../../models/project/product_model.dart';

class PharmacyProductCard extends StatelessWidget {
  final PharmacyProduct product;
  final VoidCallback onTap;
  final VoidCallback? onAddToCart;
  final bool showFullDetails;

  const PharmacyProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.onAddToCart,
    this.showFullDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2, // Lebih kecil
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Radius lebih kecil
      ),
      clipBehavior: Clip.antiAlias,
      color: Colors.grey[50], // Warna abu-abu terang untuk background
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(context),

            Padding(
              padding: const EdgeInsets.all(12), // Padding lebih kecil
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBadgesSection(),

                  const SizedBox(height: 6),

                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600, // Font weight lebih ringan
                      fontSize: 14, // Font size lebih kecil
                      color: Colors.grey[800], // Warna lebih gelap
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 2),

                  Text(
                    product.manufacturer,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[500], // Abu-abu medium
                      fontSize: 10, // Lebih kecil
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Rating & Reviews
                  _buildRatingSection(),

                  const SizedBox(height: 8),

                  // Price & Stock
                  _buildPriceStockSection(),

                  if (showFullDetails) ...[
                    const SizedBox(height: 8),
                    _buildAdditionalDetails(),
                  ],

                  const SizedBox(height: 8),

                  // Action Buttons
                  _buildActionButtons(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Stack(
      children: [
        // Product Image - lebih kecil
        Container(
          height: showFullDetails ? 140 : 120, // Tinggi lebih kecil
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200], // Background abu-abu
            image: DecorationImage(
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Featured Badge - lebih kecil
        if (product.isFeatured)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.amber[700],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'FEATURED',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8, // Font lebih kecil
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

        // Stock Badge - lebih kecil
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: product.stockColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              product.stockStatus,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8, // Font lebih kecil
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBadgesSection() {
    return Row(
      children: [
        // Category Badge - lebih kecil
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50], // Abu-abu kebiruan
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.blueGrey.shade500),
          ),
          child: Text(
            product.category.split(' ').first,
            style: TextStyle(
              fontSize: 9, // Lebih kecil
              color: Colors.blueGrey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const SizedBox(width: 6),

        // Prescription Badge - lebih kecil
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color:
                product.isPrescription ? Colors.orange[50] : Colors.green[50],
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: product.isPrescription ? Colors.orange : Colors.green,
            ),
          ),
          child: Text(
            product.prescriptionText,
            style: TextStyle(
              fontSize: 9, // Lebih kecil
              color:
                  product.isPrescription
                      ? Colors.orange[700]
                      : Colors.green[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Expiry Badge (if showFullDetails) - lebih kecil
        if (showFullDetails) ...[
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: product.expiryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: product.expiryColor.withOpacity(0.3)),
            ),
            child: Text(
              product.expiryText,
              style: TextStyle(
                fontSize: 9, // Lebih kecil
                color: product.expiryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRatingSection() {
    return Row(
      children: [
        // Stars - lebih kecil
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < product.rating.floor()
                  ? Icons.star
                  : index < product.rating
                  ? Icons.star_half
                  : Icons.star_border,
              size: 14, // Icon lebih kecil
              color: Colors.amber[600],
            );
          }),
        ),

        const SizedBox(width: 4),

        // Rating Number - lebih kecil
        Text(
          product.rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),

        const SizedBox(width: 4),

        // Review Count - lebih kecil
        Text(
          '(${product.reviewCount})',
          style: TextStyle(fontSize: 11, color: Colors.grey[500]),
        ),
      ],
    );
  }

  Widget _buildPriceStockSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Price - lebih kecil
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.formattedPrice,
              style: const TextStyle(
                fontSize: 16, // Sedikit lebih kecil
                fontWeight: FontWeight.w700,
                color: Colors.blueGrey, // Warna abu-abu kebiruan
              ),
            ),
            if (showFullDetails)
              Text(
                '/ ${product.dosage}',
                style: TextStyle(fontSize: 10, color: Colors.grey[500]),
              ),
          ],
        ),

        // Stock Info - lebih kecil
        Row(
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 12, // Icon lebih kecil
              color: product.stockColor,
            ),
            const SizedBox(width: 4),
            Text(
              '${product.stock} pcs',
              style: TextStyle(
                fontSize: 11,
                color: product.stockColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdditionalDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description
        Text(
          product.description,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 8),

        // Tags
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children:
              product.tags.map((tag) {
                return Chip(
                  label: Text(tag, style: const TextStyle(fontSize: 10)),
                  backgroundColor: Colors.grey[100],
                  padding: EdgeInsets.zero,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        // Detail Button - lebih kecil
        Expanded(
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ), // Padding lebih kecil
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6), // Radius lebih kecil
              ),
              side: BorderSide(
                color: Colors.blueGrey[400]!,
              ), // Warna abu-abu kebiruan
            ),
            child: Text(
              'Detail',
              style: TextStyle(
                fontSize: 12, // Font lebih kecil
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey[700],
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Add to Cart Button - lebih kecil
        if (onAddToCart != null && product.stock > 0)
          Container(
            width: 36, // Lebih kecil
            height: 36,
            decoration: BoxDecoration(
              color: Colors.blueGrey[600], // Warna abu-abu kebiruan
              borderRadius: BorderRadius.circular(6),
            ),
            child: IconButton(
              onPressed: onAddToCart,
              icon: const Icon(
                Icons.add_shopping_cart,
                size: 16, // Icon lebih kecil
                color: Colors.white,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
      ],
    );
  }
}

// Grid View untuk multiple products
class PharmacyProductGridView extends StatelessWidget {
  final List<PharmacyProduct> products;
  final int crossAxisCount;
  final bool showFullDetails;

  const PharmacyProductGridView({
    super.key,
    required this.products,
    this.crossAxisCount = 2,
    this.showFullDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: showFullDetails ? 0.7 : 0.85,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return PharmacyProductCard(
          product: product,
          onTap: () {
            // Navigate to product detail
            _showProductDetail(context, product);
          },
          onAddToCart: () {
            // Add to cart logic
            _addToCart(context, product);
          },
          showFullDetails: showFullDetails,
        );
      },
    );
  }

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

  void _addToCart(BuildContext context, PharmacyProduct product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} ditambahkan ke keranjang'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// Bottom Sheet untuk Product Detail
class ProductDetailBottomSheetNew extends StatelessWidget {
  final PharmacyProduct product;

  const ProductDetailBottomSheetNew({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Drag Handle dengan shadow untuk highlight
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image dengan shadow dan border radius
                      Container(
                        height: 250,
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                              spreadRadius: 1,
                            ),
                          ],
                          image: DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Product Name & Manufacturer
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              product.manufacturer,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Price & Rating Row dengan container background
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Price Section
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Harga',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.formattedPrice,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),

                            // Rating Section
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'Rating',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    ...List.generate(5, (index) {
                                      return Icon(
                                        index < product.rating.floor()
                                            ? Icons.star_rounded
                                            : Icons.star_border_rounded,
                                        size: 20,
                                        color: Colors.amber[700],
                                      );
                                    }),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${product.rating.toStringAsFixed(1)}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '(${product.reviewCount} ulasan)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Info Grid dengan spacing yang lebih baik
                      Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Informasi Produk',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              childAspectRatio: 3.1,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              children: [
                                _buildInfoTile(
                                  'Kategori',
                                  product.category,
                                  Icons.category_rounded,
                                  Colors.blue,
                                ),
                                _buildInfoTile(
                                  'Dosis',
                                  product.dosage,
                                  Icons.medical_services_rounded,
                                  Colors.green,
                                ),
                                _buildInfoTile(
                                  'Stok',
                                  '${product.stock} pcs',
                                  Icons.inventory_rounded,
                                  Colors.orange,
                                ),
                                _buildInfoTile(
                                  'Resep',
                                  product.prescriptionText,
                                  Icons.description_rounded,
                                  Colors.purple,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Description dengan background
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 24),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline_rounded,
                                  color: Colors.blue[700],
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Deskripsi Produk',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              product.description,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                                height: 1.6,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),

                      // Tags section dengan icon
                      Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.local_offer_rounded,
                                  color: Colors.blue[700],
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Tags',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children:
                                  product.tags.map((tag) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.blue[50]!,
                                            Colors.blue[100]!,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.blue[200]!,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blue.withOpacity(0.1),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        tag,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue[800],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),
                      ),

                      // Action Buttons dengan elevated design
                      Container(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.grey[800],
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 18,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: Colors.grey[300]!,
                                        width: 1,
                                      ),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'KEMBALI',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Add to cart logic
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[600],
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 18,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'TAMBAH KE KERANJANG',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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

  Widget _buildInfoTile(
    String title,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailBottomSheet extends StatelessWidget {
  final PharmacyProduct product;

  const ProductDetailBottomSheet({
    Key? key, // PERBAIKAN: Ubah super.key menjadi Key? key
    required this.product,
  }) : super(key: key); // PERBAIKAN: Tambahkan super(key: key)

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Drag Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Product Name & Manufacturer
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        product.manufacturer,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),

                      const SizedBox(height: 16),

                      // Price & Rating Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.formattedPrice,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: Colors.blue,
                            ),
                          ),
                          Row(
                            children: [
                              ...List.generate(5, (index) {
                                return Icon(
                                  index < product.rating.floor()
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 20,
                                  color: Colors.amber,
                                );
                              }),
                              const SizedBox(width: 8),
                              Text(
                                '${product.rating.toStringAsFixed(1)} (${product.reviewCount})',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Info Grid
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 9,
                        mainAxisSpacing: 12,

                        children: [
                          _buildInfoTile(
                            'Kategori',
                            product.category,
                            Icons.category,
                          ),
                          _buildInfoTile(
                            'Dosis',
                            product.dosage,
                            Icons.medical_services,
                          ),
                          _buildInfoTile(
                            'Stok',
                            '${product.stock} pcs',
                            Icons.inventory,
                          ),
                          _buildInfoTile(
                            'Resep',
                            product.prescriptionText,
                            Icons.description,
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Description
                      const Text(
                        'Deskripsi Produk',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Tags
                      const Text(
                        'Tags',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            product.tags.map((tag) {
                              return Chip(
                                label: Text(tag),
                                backgroundColor: Colors.blue[50],
                                labelStyle: const TextStyle(color: Colors.blue),
                              );
                            }).toList(),
                      ),

                      const SizedBox(height: 32),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('KEMBALI'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Add to cart logic
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('TAMBAH KE KERANJANG'),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),
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

  Widget _buildInfoTile(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 12),

          // 🔥 Perbaikan utama: Expanded agar teks tidak overflow
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 3, // tetap 2 baris
                  overflow: TextOverflow.ellipsis, // auto "..."
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
