import 'package:dio/dio.dart';
import 'package:news_app/core/sensitive_data.dart';

class ApiServices {
  final String _baseUrl = 'https://newsapi.org/v2/';
  final Dio _dio;

  ApiServices(this._dio);

  Future<Map<String, dynamic>> get({
    String endpoint = 'everything',
    String pageSize = '10',
  }) async {
    var response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'q': endpoint,
        'apiKey': SensitiveData.apiKey,
        'pageSize': pageSize,
      },
    );

    return response.data;
  }
}
