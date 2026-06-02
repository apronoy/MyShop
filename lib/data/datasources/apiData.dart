import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_product/core/constants/api_constants.dart';
import 'package:my_product/data/models/product_model.dart';

class ApiData {
  Future<List<ProductModel>> getProducts() async {
    final response = await http.get(Uri.parse(Endpoints.baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return List<ProductModel>.from(data.map((x) => ProductModel.fromJson(x)));
    }

    throw Exception("Failed to load products");
  }
}
