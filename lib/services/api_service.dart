import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com/products';

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final Uri uri = Uri.parse(_baseUrl);
      final http.Response response = await http
          .get(uri)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw Exception('Ürünler alınamadı. HTTP: ${response.statusCode}');
      }

      final dynamic decodedBody = jsonDecode(response.body);

      if (decodedBody is! List) {
        throw Exception('Beklenmeyen veri formatı alındı.');
      }

      return decodedBody
          .map(
            (dynamic item) =>
                ProductModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } catch (error) {
      throw Exception('Ürünler yüklenirken hata oluştu: $error');
    }
  }
}
