import 'package:dio/dio.dart';
import 'package:news_app/core/sensitive_data.dart';

class ApiServices {
  final String _baseUrl = 'https://newsapi.org/v2/everything';
  final Dio _dio;

  ApiServices(this._dio);

  Future<Map<String, dynamic>> get({
    String? category,
    int? page,
  }) async {
    var response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'q':  "everything",
        'apiKey': SensitiveData.anotherApiKey,
        'page': page ?? 1,
        'pageSize': 10,
      },
    );

    return response.data;
  }
}
