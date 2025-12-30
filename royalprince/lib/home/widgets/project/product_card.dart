// lib/home/widgets/shop/product_card.dart
import 'package:flutter/material.dart';
import '../../models/project/product_model.dart'; // PATH YANG DIPERBAIKI

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
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      color: Colors.black87.withOpacity(0.05),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(context),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBadgesSection(),

                  const SizedBox(height: 6),

                  // Product Name - dengan null safety
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 2),

                  // Manufacturer - dengan null safety
                  Text(
                    product.manufacturer,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[500],
                      fontSize: 10,
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
        // Product Image dengan error handling - DIPERBAIKI
        Container(
          height: showFullDetails ? 140 : 120,
          width: double.infinity,
          color: Colors.grey[200],
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: Center(
                  child: Icon(
                    Icons.medical_services,
                    color: Colors.grey[500],
                    size: 40,
                  ),
                ),
              );
            },
          ),
        ),

        // Featured Badge
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
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

        // Stock Badge
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
                fontSize: 8,
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
        // Category Badge - ambil kata pertama saja
        if (product.category.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.blueGrey.shade500),
            ),
            child: Text(
              product.category.split(' ').first,
              style: TextStyle(
                fontSize: 9,
                color: Colors.blueGrey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 6),
        ],

        // Prescription Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: product.isPrescription ? Colors.orange[50] : Colors.green[50],
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: product.isPrescription ? Colors.orange : Colors.green,
            ),
          ),
          child: Text(
            product.prescriptionText,
            style: TextStyle(
              fontSize: 9,
              color: product.isPrescription
                  ? Colors.orange[700]
                  : Colors.green[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Expiry Badge (hanya jika showFullDetails)
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
                fontSize: 9,
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
        // Stars
        Row(
          children: List.generate(5, (index) {
            final rating = product.rating;
            return Icon(
              index < rating.floor()
                  ? Icons.star
                  : (index < rating ? Icons.star_half : Icons.star_border),
              size: 14,
              color: Colors.amber[600],
            );
          }),
        ),

        const SizedBox(width: 4),

        // Rating Number
        Text(
          product.rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),

        const SizedBox(width: 4),

        // Review Count
        Text(
          '(${product.reviewCount})',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceStockSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Price
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.formattedPrice,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.blueGrey,
              ),
            ),
            if (showFullDetails && product.dosage.isNotEmpty)
              Text(
                '/ ${product.dosage}',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[500],
                ),
              ),
          ],
        ),

        // Stock Info - hanya tampilkan jika stok > 0
        if (product.stock > 0)
          Row(
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 12,
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
        if (product.description.isNotEmpty)
          Text(
            product.description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

        if (product.description.isNotEmpty) const SizedBox(height: 8),

        // Tags
        if (product.tags.isNotEmpty)
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: product.tags.map((tag) {
              return Chip(
                label: Text(
                  tag,
                  style: const TextStyle(fontSize: 10),
                ),
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
        // Detail Button
        Expanded(
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              side: BorderSide(
                color: Colors.blueGrey[400]!,
              ),
            ),
            child: Text(
              'Detail',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey[700],
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Add to Cart Button - hanya jika ada stock
        if (onAddToCart != null && product.stock > 0)
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.blueGrey[600],
              borderRadius: BorderRadius.circular(6),
            ),
            child: IconButton(
              onPressed: onAddToCart,
              icon: const Icon(
                Icons.add_shopping_cart,
                size: 16,
                color: Colors.white,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
      ],
    );
  }
}

// ===================== PRODUCT GRID VIEW =====================

class PharmacyProductGridView extends StatelessWidget {
  final List<PharmacyProduct> products;
  final int crossAxisCount;
  final bool showFullDetails;
  final Function(PharmacyProduct)? onProductTap;
  final Function(PharmacyProduct)? onAddToCart;

  const PharmacyProductGridView({
    super.key,
    required this.products,
    this.crossAxisCount = 2,
    this.showFullDetails = false,
    this.onProductTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return _buildEmptyState();
    }

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
          onTap: () => _handleProductTap(context, product),
          onAddToCart: onAddToCart != null
              ? () => onAddToCart!(product)
              : null,
          showFullDetails: showFullDetails,
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada produk',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Produk akan muncul di sini',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _handleProductTap(BuildContext context, PharmacyProduct product) {
    if (onProductTap != null) {
      onProductTap!(product);
    } else {
      // Default behavior: show detail sheet
      _showProductDetail(context, product);
    }
  }

  void _showProductDetail(BuildContext context, PharmacyProduct product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ProductDetailBottomSheet(
          product: product,
          showFullDetails: showFullDetails,
        );
      },
    );
  }

  void _addToCart(BuildContext context, PharmacyProduct product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} ditambahkan ke keranjang'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

// ===================== PRODUCT DETAIL BOTTOM SHEET =====================

class ProductDetailBottomSheet extends StatelessWidget {
  final PharmacyProduct product;
  final bool showFullDetails; // PARAMETER BARU DITAMBAHKAN

  const ProductDetailBottomSheet({
    super.key,
    required this.product,
    this.showFullDetails = false, // DEFAULT VALUE
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
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
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
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
                      // Product Image dengan error handling - DIPERBAIKI
                      Container(
                        height: 250,
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[200],
                        ),
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: Center(
                                child: Icon(
                                  Icons.medical_services,
                                  color: Colors.grey[500],
                                  size: 60,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Product Name & Manufacturer
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      if (product.manufacturer.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            product.manufacturer,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),

                      const SizedBox(height: 20),

                      // Price & Rating Row
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Price
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Harga',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
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

                            // Rating
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Rating',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    ...List.generate(5, (index) {
                                      return Icon(
                                        index < product.rating.floor()
                                            ? Icons.star
                                            : Icons.star_border,
                                        size: 20,
                                        color: Colors.amber[700],
                                      );
                                    }),
                                    const SizedBox(width: 8),
                                    Text(
                                      product.rating.toStringAsFixed(1),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87,
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

                      const SizedBox(height: 20),

                      // Info Grid
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        children: [
                          _buildInfoTile(
                            'Kategori',
                            product.category,
                            Icons.category,
                            Colors.blue,
                          ),
                          _buildInfoTile(
                            'Dosis',
                            product.dosage,
                            Icons.medical_services,
                            Colors.green,
                          ),
                          _buildInfoTile(
                            'Stok',
                            '${product.stock} pcs',
                            Icons.inventory,
                            Colors.orange,
                          ),
                          _buildInfoTile(
                            'Resep',
                            product.prescriptionText,
                            Icons.description,
                            Colors.purple,
                          ),
                          if (showFullDetails)
                            _buildInfoTile(
                              'Kadaluarsa',
                              product.expiryText,
                              Icons.calendar_today,
                              product.expiryColor,
                            ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Description
                      if (product.description.isNotEmpty) ...[
                        const Text(
                          'Deskripsi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
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
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Tags
                      if (product.tags.isNotEmpty) ...[
                        const Text(
                          'Tags',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: product.tags.map((tag) {
                            return Chip(
                              label: Text(tag),
                              backgroundColor: Colors.blue[50],
                              labelStyle: const TextStyle(color: Colors.blue),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                      ],
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: iconColor,
            ),
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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