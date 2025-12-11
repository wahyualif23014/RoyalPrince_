// lib/models/shop/product_model.dart
import 'package:flutter/material.dart';
import 'dart:async';
class PharmacyProduct {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final bool isPrescription;
  final List<String> tags;
  final int stock;
  final String manufacturer;
  final String dosage;
  final DateTime expiryDate;
  final bool isFeatured;

  PharmacyProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.isPrescription,
    required this.tags,
    required this.stock,
    required this.manufacturer,
    required this.dosage,
    required this.expiryDate,
    required this.isFeatured,
  });

  // Factory method untuk create dummy data
  factory PharmacyProduct.dummy(String id) {
    final now = DateTime.now();
    final expiryDate = now.add(const Duration(days: 365 * 2)); // 2 tahun dari sekarang
    
    // Kategori dan data sesuai dengan jenis obat
    final categories = [
      'Analgesik & Antiinflamasi',
      'Antibiotik',
      'Vitamin & Suplemen',
      'Obat Jantung',
      'Obat Diabetes',
      'Obat Pernafasan',
      'Obat Kulit',
      'Obat Mata',
      'Alat Kesehatan',
      'Herbal',
    ];
    
    final manufacturers = [
      'Kalbe Farma',
      'Kimia Farma',
      'Dexa Medica',
      'Sanbe Farma',
      'Phapros',
      'Soho Global Health',
      'Indofarma',
      'Pyridam Farma',
      'Bintang Toedjoe',
      'Konimex',
    ];
    
    final category = categories[id.hashCode % categories.length];
    final manufacturer = manufacturers[id.hashCode % manufacturers.length];
    
    return PharmacyProduct(
      id: id,
      name: _generateProductName(id),
      description: _generateDescription(category),
      category: category,
      price: _generatePrice(id),
      imageUrl: _generateImageUrl(id),
      rating: 3.5 + (id.hashCode % 15) / 10, // Rating 3.5 - 5.0
      reviewCount: 10 + (id.hashCode % 100),
      isPrescription: id.hashCode % 3 == 0, // 33% butuh resep
      tags: _generateTags(category),
      stock: 50 + (id.hashCode % 150),
      manufacturer: manufacturer,
      dosage: _generateDosage(category),
      expiryDate: expiryDate,
      isFeatured: id.hashCode % 4 == 0, // 25% featured
    );
  }

  static String _generateProductName(String id) {
    final names = [
      'Paracetamol 500mg',
      'Amoxicillin 500mg',
      'Vitamin C 1000mg',
      'Omeprazole 20mg',
      'Metformin 500mg',
      'Salbutamol Inhaler',
      'Cetirizine 10mg',
      'Ibuprofen 400mg',
      'Losartan 50mg',
      'Simvastatin 20mg',
      'Aspirin 80mg',
      'Loratadine 10mg',
      'Diazepam 5mg',
      'Metronidazole 500mg',
      'Furosemide 40mg',
      'Insulin Pen',
      'Albuterol Nebulizer',
      'Hydrocortisone Cream',
      'Antasida Tablet',
      'Oral Rehydration Salt',
    ];
    return names[id.hashCode % names.length];
  }

  static String _generateDescription(String category) {
    final descriptions = {
      'Analgesik & Antiinflamasi': 'Obat pereda nyeri dan anti inflamasi untuk meredakan sakit kepala, demam, dan nyeri otot.',
      'Antibiotik': 'Obat untuk mengatasi infeksi bakteri dengan dosis yang sesuai resep dokter.',
      'Vitamin & Suplemen': 'Suplemen untuk menjaga daya tahan tubuh dan memenuhi kebutuhan nutrisi harian.',
      'Obat Jantung': 'Obat untuk menjaga kesehatan jantung dan tekanan darah dengan dosis teratur.',
      'Obat Diabetes': 'Obat untuk mengontrol kadar gula darah dengan monitoring rutin.',
      'Obat Pernafasan': 'Obat untuk meredakan gejala gangguan pernafasan seperti asma dan bronkitis.',
      'Obat Kulit': 'Obat untuk mengatasi masalah kulit seperti gatal, ruam, dan infeksi.',
      'Obat Mata': 'Obat tetes mata untuk mengatasi mata merah, iritasi, dan infeksi.',
      'Alat Kesehatan': 'Alat kesehatan untuk monitoring dan perawatan kesehatan di rumah.',
      'Herbal': 'Obat herbal alami untuk menjaga kesehatan tubuh secara tradisional.',
    };
    return descriptions[category] ?? 'Obat untuk menjaga kesehatan dengan dosis yang tepat.';
  }

  static double _generatePrice(String id) {
    final basePrice = [5000, 15000, 25000, 50000, 75000, 100000];
    return basePrice[id.hashCode % basePrice.length].toDouble();
  }

  static String _generateImageUrl(String id) {
    // Placeholder images dengan kategori berbeda
    final imageTypes = [
      'pill_red',
      'pill_blue', 
      'pill_green',
      'bottle',
      'inhaler',
      'syrup',
      'cream',
      'drops',
      'injection',
      'herbal',
    ];
    final type = imageTypes[id.hashCode % imageTypes.length];
    return 'https://via.placeholder.com/300x200/2C3E50/FFFFFF?text=$type';
  }

  static List<String> _generateTags(String category) {
    final tagMap = {
      'Analgesik & Antiinflamasi': ['Pereda Nyeri', 'Anti Demam', 'Non-Resep'],
      'Antibiotik': ['Infeksi', 'Resep Dokter', 'Bakteri'],
      'Vitamin & Suplemen': ['Daya Tahan', 'Nutrisi', 'Non-Resep'],
      'Obat Jantung': ['Hipertensi', 'Kolesterol', 'Resep'],
      'Obat Diabetes': ['Gula Darah', 'Resep', 'Monitoring'],
      'Obat Pernafasan': ['Asma', 'Bronkitis', 'Inhaler'],
      'Obat Kulit': ['Topikal', 'Ruam', 'Non-Resep'],
      'Obat Mata': ['Tetes', 'Iritasi', 'Non-Resep'],
      'Alat Kesehatan': ['Monitor', 'Alat Ukur', 'Non-Obat'],
      'Herbal': ['Alami', 'Tradisional', 'Non-Resep'],
    };
    return tagMap[category] ?? ['Obat', 'Kesehatan'];
  }

  static String _generateDosage(String category) {
    final dosageMap = {
      'Analgesik & Antiinflamasi': '1 tablet setiap 4-6 jam',
      'Antibiotik': '1 tablet 3x sehari (sesuai resep)',
      'Vitamin & Suplemen': '1 tablet sehari setelah makan',
      'Obat Jantung': '1 tablet pagi hari',
      'Obat Diabetes': '1 tablet sebelum makan',
      'Obat Pernafasan': '2 semprot saat diperlukan',
      'Obat Kulit': 'Oleskan tipis 2x sehari',
      'Obat Mata': '1-2 tetes 3x sehari',
      'Alat Kesehatan': 'Gunakan sesuai petunjuk',
      'Herbal': '1 kapsul 2x sehari',
    };
    return dosageMap[category] ?? 'Sesuai petunjuk dokter';
  }

  // Helper methods
  String get formattedPrice => 'Rp ${price.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      )}';

  String get stockStatus {
    if (stock <= 0) return 'Habis';
    if (stock <= 10) return 'Terbatas';
    if (stock <= 50) return 'Tersedia';
    return 'Stok Banyak';
  }

  Color get stockColor {
    if (stock <= 0) return Colors.red;
    if (stock <= 10) return Colors.orange;
    if (stock <= 50) return Colors.blue;
    return Colors.green;
  }

  String get prescriptionText => isPrescription ? 'Butuh Resep' : 'Bebas Resep';
  Color get prescriptionColor => isPrescription ? Colors.orange : Colors.green;

  String get expiryText {
    final now = DateTime.now();
    final difference = expiryDate.difference(now).inDays;
    
    if (difference <= 0) return 'Kadaluarsa';
    if (difference <= 30) return '$difference hari lagi';
    if (difference <= 90) return '${difference ~/ 30} bulan lagi';
    return '${difference ~/ 365} tahun lagi';
  }

  Color get expiryColor {
    final now = DateTime.now();
    final difference = expiryDate.difference(now).inDays;
    
    if (difference <= 0) return Colors.red;
    if (difference <= 30) return Colors.orange;
    if (difference <= 90) return Colors.yellow;
    return Colors.green;
  }

  // To JSON untuk API
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'category': category,
    'price': price,
    'imageUrl': imageUrl,
    'rating': rating,
    'reviewCount': reviewCount,
    'isPrescription': isPrescription,
    'tags': tags,
    'stock': stock,
    'manufacturer': manufacturer,
    'dosage': dosage,
    'expiryDate': expiryDate.toIso8601String(),
    'isFeatured': isFeatured,
  };

  // From JSON untuk API
  factory PharmacyProduct.fromJson(Map<String, dynamic> json) {
    return PharmacyProduct(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'],
      isPrescription: json['isPrescription'],
      tags: List<String>.from(json['tags']),
      stock: json['stock'],
      manufacturer: json['manufacturer'],
      dosage: json['dosage'],
      expiryDate: DateTime.parse(json['expiryDate']),
      isFeatured: json['isFeatured'],
    );
  }
}

// Kategori produk untuk filter
class ProductCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final int productCount;

  const ProductCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.productCount,
  });
}

// Data dummy categories
final List<ProductCategory> productCategories = [
  ProductCategory(
    id: 'analgesik',
    name: 'Analgesik',
    icon: Icons.sick,
    color: Colors.red,
    productCount: 24,
  ),
  ProductCategory(
    id: 'antibiotik',
    name: 'Antibiotik',
    icon: Icons.health_and_safety,
    color: Colors.blue,
    productCount: 18,
  ),
  ProductCategory(
    id: 'vitamin',
    name: 'Vitamin',
    icon: Icons.local_hospital,
    color: Colors.green,
    productCount: 32,
  ),
  ProductCategory(
    id: 'jantung',
    name: 'Jantung',
    icon: Icons.favorite,
    color: Colors.pink,
    productCount: 12,
  ),
  ProductCategory(
    id: 'diabetes',
    name: 'Diabetes',
    icon: Icons.bloodtype,
    color: Colors.purple,
    productCount: 15,
  ),
  ProductCategory(
    id: 'pernafasan',
    name: 'Pernafasan',
    icon: Icons.air,
    color: Colors.cyan,
    productCount: 20,
  ),
  ProductCategory(
    id: 'kulit',
    name: 'Kulit',
    icon: Icons.face,
    color: Colors.orange,
    productCount: 16,
  ),
  ProductCategory(
    id: 'mata',
    name: 'Mata',
    icon: Icons.remove_red_eye,
    color: Colors.indigo,
    productCount: 8,
  ),
  ProductCategory(
    id: 'alat',
    name: 'Alat Kesehatan',
    icon: Icons.medical_services,
    color: Colors.teal,
    productCount: 25,
  ),
  ProductCategory(
    id: 'herbal',
    name: 'Herbal',
    icon: Icons.spa,
    color: Colors.brown,
    productCount: 30,
  ),
];

// Filter options untuk produk
class ProductFilter {
  final String id;
  final String name;
  final String value;

  const ProductFilter({
    required this.id,
    required this.name,
    required this.value,
  });
}

final List<ProductFilter> productFilters = [
  ProductFilter(id: 'all', name: 'Semua', value: 'all'),
  ProductFilter(id: 'prescription', name: 'Butuh Resep', value: 'prescription'),
  ProductFilter(id: 'non_prescription', name: 'Bebas Resep', value: 'non_prescription'),
  ProductFilter(id: 'featured', name: 'Featured', value: 'featured'),
  ProductFilter(id: 'discount', name: 'Diskon', value: 'discount'),
  ProductFilter(id: 'stock', name: 'Stok Tersedia', value: 'stock'),
];

// Sorting options
class ProductSort {
  final String id;
  final String name;
  final String value;

  const ProductSort({
    required this.id,
    required this.name,
    required this.value,
  });
}

final List<ProductSort> productSortOptions = [
  ProductSort(id: 'popular', name: 'Populer', value: 'popular'),
  ProductSort(id: 'newest', name: 'Terbaru', value: 'newest'),
  ProductSort(id: 'price_low', name: 'Harga Terendah', value: 'price_low'),
  ProductSort(id: 'price_high', name: 'Harga Tertinggi', value: 'price_high'),
  ProductSort(id: 'rating', name: 'Rating Tertinggi', value: 'rating'),
  ProductSort(id: 'name', name: 'Nama A-Z', value: 'name'),
];