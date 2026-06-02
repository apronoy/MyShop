import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final http.Client client;

  ApiService(this.client);

  Future<dynamic> getProduct(String url) async {
    try {
      final response = await client
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      throw Exception('Server Error: ${response.statusCode}');
    } catch (e) {
      rethrow;
    }
  }
}
