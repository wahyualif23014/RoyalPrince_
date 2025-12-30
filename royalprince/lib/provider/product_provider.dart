import 'package:flutter/material.dart';
import '../home/models/project/product_model.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<PharmacyProduct> _products = [];
  List<PharmacyProduct> _filteredProducts = [];
  List<String> _categories = [];
  bool _isLoading = false;
  String _error = '';
  
  // Getters
  List<PharmacyProduct> get products => _filteredProducts;
  List<PharmacyProduct> get allProducts => _products;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading;
  String get error => _error;
  
  // Fetch semua produk dari API
  Future<void> fetchProducts({String? category}) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();
      
      // Fetch dari API
      _products = await ApiService.getProducts(
        category: category,
        limit: 50,
      );
      
      _filteredProducts = List.from(_products);
      
      // Fetch kategori
      _categories = await ApiService.getCategories();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Gagal memuat produk: $e';
      notifyListeners();
    }
  }
  
  // Filter produk
  void filterProducts({
    String? category,
    bool? prescriptionRequired,
    double? minPrice,
    double? maxPrice,
  }) {
    _filteredProducts = _products.where((product) {
      bool matches = true;
      
      if (category != null && category.isNotEmpty) {
        matches = matches && product.category == category;
      }
      
      if (prescriptionRequired != null) {
        matches = matches && product.isPrescription == prescriptionRequired;
      }
      
      if (minPrice != null) {
        matches = matches && product.price >= minPrice;
      }
      
      if (maxPrice != null) {
        matches = matches && product.price <= maxPrice;
      }
      
      return matches;
    }).toList();
    
    notifyListeners();
  }
  
  // Reset filter
  void resetFilter() {
    _filteredProducts = List.from(_products);
    notifyListeners();
  }
  
  // Search produk
  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = List.from(_products);
    } else {
      _filteredProducts = _products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase()) ||
               product.category.toLowerCase().contains(query.toLowerCase()) ||
               product.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()));
      }).toList();
    }
    
    notifyListeners();
  }
  
  // Get produk by ID
  PharmacyProduct? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}