// lib/models/shop/product_model.dart
import 'package:flutter/material.dart';

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

  // --- Helper Methods untuk UI Logic (Tetap dipertahankan) ---

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

  // Warna indikator stok
  Color get stockColor {
    if (stock <= 0) return Colors.red;
    if (stock <= 10) return Colors.orange;
    if (stock <= 50) return Colors.blue;
    return Colors.green;
  }

  // Text label resep
  String get prescriptionText => isPrescription ? 'Butuh Resep' : 'Bebas Resep';
  
  // Warna label resep
  Color get prescriptionColor => isPrescription ? Colors.orange : Colors.green;

  // Text status kadaluarsa
  String get expiryText {
    final now = DateTime.now();
    final difference = expiryDate.difference(now).inDays;
    
    if (difference <= 0) return 'Kadaluarsa';
    if (difference <= 30) return '$difference hari lagi';
    if (difference <= 90) return '${difference ~/ 30} bulan lagi';
    return '${difference ~/ 365} tahun lagi';
  }

  // Warna indikator kadaluarsa
  Color get expiryColor {
    final now = DateTime.now();
    final difference = expiryDate.difference(now).inDays;
    
    if (difference <= 0) return Colors.red;
    if (difference <= 30) return Colors.orange;
    if (difference <= 90) return Colors.yellow;
    return Colors.green;
  }

  // --- Serialization (JSON) ---

  // Mengubah object ke JSON (untuk kirim ke API)
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

  // Membuat object dari JSON (dari respon API)
  factory PharmacyProduct.fromJson(Map<String, dynamic> json) {
    return PharmacyProduct(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      isPrescription: json['isPrescription'] ?? false,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      stock: json['stock'] ?? 0,
      manufacturer: json['manufacturer'] ?? '',
      dosage: json['dosage'] ?? '',
      expiryDate: json['expiryDate'] != null 
          ? DateTime.parse(json['expiryDate']) 
          : DateTime.now(),
      isFeatured: json['isFeatured'] ?? false,
    );
  }
}

// --- Auxiliary Classes (Model Pendukung) ---

// Kategori produk
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

// Filter produk
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

// Sorting produk
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