import 'package:dio/dio.dart';
import 'package:news_app/core/sensitive_data.dart';

class ApiServices {
  final String _baseUrl = 'https://newsapi.org/v2/top-headlines';
  final Dio _dio;

  ApiServices(this._dio);

  Future<Map<String, dynamic>> get({
    String? category,
    int? pageSize,
  }) async {
    var response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'category':  category ?? "technology",
        'apiKey': SensitiveData.apiKey,
        'pagesize': pageSize ?? 10,
      },
    );

    return response.data;
  }
}
