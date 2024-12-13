import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  final Dio dio;

  DioClient()
      : dio = Dio(BaseOptions(
          baseUrl: Platform.isAndroid ? 'http://10.0.2.2:3001' : 'http://localhost:3001',
          connectTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 5000),
          headers: {'Content-Type': 'application/json'},
        )) {
    _addInterceptors();
  }

  void _addInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('Request: ${options.method} ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('Response: ${response.statusCode} ${response.data}');
        return handler.next(response);
      },
      onError: (DioException error, handler) {
        debugPrint('Error: ${error.response?.statusCode} ${error.message}');
        return handler.next(error);
      },
    ));
  }
}
