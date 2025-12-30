import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../home/models/project/product_model.dart'; 

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message (Code: $statusCode)';
}

class ApiService {
  // ===================== KONFIGURASI =====================
  
  // IP 10.0.2.2 adalah localhost khusus untuk Android Emulator
  static const String _baseUrl = 'http://localhost:8000/api/v1/'; 
  static const String _apiKey = 'WYg7KpR9sL2vN5tQ8xZ0cF3jH6mB4nV1qT9uX2wC5yG8';
  
  // Timeout: Kita set 15 detik
  static const Duration _timeout = Duration(seconds: 15);

  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-API-Key': _apiKey,
  };

  // ===================== CORE REQUEST HANDLER =====================
  
  static Future<dynamic> _get(String endpoint, {Map<String, String>? queryParams}) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint').replace(queryParameters: queryParams);
      
      print('🔄 [GET] Request: $uri');

      final response = await http.get(uri, headers: _headers).timeout(_timeout);

      print('✅ [GET] Response Code: ${response.statusCode}');


      return _processResponse(response);

    } on SocketException {
      throw ApiException('Tidak ada koneksi internet atau server tidak dapat dijangkau (Cek Firewall/IP).');
    } on http.ClientException {
      throw ApiException('Terjadi kesalahan pada klien HTTP.');
    } catch (e) {
      throw ApiException('Error tidak diketahui: $e');
    }
  }

  static dynamic _processResponse(http.Response response) {
    // Handle jika response body kosong
    if (response.body.isEmpty) {
        throw ApiException('Server mengembalikan respon kosong.', statusCode: response.statusCode);
    }

    final body = json.decode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Sesuaikan dengan format response backend kamu
      // Jika backend langsung return list/object tanpa wrapper 'status', ubah logika ini.
      if (body is Map && body.containsKey('status')) {
         if (body['status'] == 'success') {
            return body['data'];
         } else {
            throw ApiException(body['message'] ?? 'API merespon dengan kegagalan.');
         }
      } else {
         // Fallback jika backend tidak pakai format {status: success, data: ...}
         // Misal langsung return list produk
         return body; 
      }
    } else if (response.statusCode == 401) {
      throw ApiException('Unauthorized: API Key tidak valid.', statusCode: 401);
    } else if (response.statusCode == 404) {
      throw ApiException('Data tidak ditemukan (404). Cek URL Endpoint.', statusCode: 404);
    } else if (response.statusCode == 307 || response.statusCode == 308) {
       throw ApiException('Redirect Error. Cek Trailing Slash (/) di URL.', statusCode: response.statusCode);
    } else {
      throw ApiException('HTTP Error: ${response.statusCode}', statusCode: response.statusCode);
    }
  }

  // ===================== PRODUCT ENDPOINTS =====================

  static Future<List<PharmacyProduct>> getProducts({
    String? category,
    bool? featured,
    bool? prescriptionRequired,
    double? minPrice,
    double? maxPrice,
    int limit = 20,
    int offset = 0,
  }) async {
    final params = <String, String>{
      'limit': limit.toString(),
      'offset': offset.toString(),
    };

    if (category != null && category != 'all') params['category'] = category;
    if (featured != null) params['featured'] = featured.toString();
    if (prescriptionRequired != null) params['prescription_required'] = prescriptionRequired.toString();
    if (minPrice != null) params['min_price'] = minPrice.toString();
    if (maxPrice != null) params['max_price'] = maxPrice.toString();

    try {
      // ⚠️ UPDATE PENTING DI SINI:
      // Menambahkan '/' di akhir karena log backend kamu: /api/v1/products/
      final data = await _get('products/', queryParams: params);
      
      // Handle jika data['products'] ada di dalam wrapper
      if (data is Map && data.containsKey('products') && data['products'] is List) {
        return (data['products'] as List)
            .map((json) => PharmacyProduct.fromJson(json))
            .toList();
      } 
      // Handle jika data langsung berupa List
      else if (data is List) {
         return data.map((json) => PharmacyProduct.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      print('❌ Error di getProducts: $e');
      rethrow;
    }
  }

  static Future<PharmacyProduct?> getProductById(String id) async {
    try {
      // Coba pakai slash juga untuk konsistensi
      final data = await _get('/products/$id'); 
      
      if (data is Map && data.containsKey('product')) {
        return PharmacyProduct.fromJson(data['product']);
      } else if (data is Map) {
         // Fallback jika tidak ada wrapper 'product'
         return PharmacyProduct.fromJson(data as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('❌ Error di getProductById: $e');
      rethrow;
    }
  }

  static Future<List<String>> getCategories() async {
    try {
      // Coba pakai slash untuk konsistensi
      final data = await _get('/products/categories/list/');
      
      if (data is Map && data.containsKey('categories') && data['categories'] is List) {
        return List<String>.from(data['categories']);
      } else if (data is List) {
        return List<String>.from(data);
      }
      return [];
    } catch (e) {
      print('❌ Error di getCategories: $e');
      return []; 
    }
  }
}