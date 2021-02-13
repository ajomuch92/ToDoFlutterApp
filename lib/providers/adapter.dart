import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Adapter {
  Dio _dio = Dio();
  String _baseUrl = env['BASE_URL'];

  Adapter() {
    _dio.options.baseUrl = _baseUrl;
  }

  Dio getAdapter() {
    return _dio;
  }
}