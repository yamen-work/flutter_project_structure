import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../errors/error_handler.dart';
import '../secure_storage/token_storage_interface.dart';
import '../network/auth_interceptor.dart';

class RemoteApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  RemoteApiService(TokenStorage tokenStorage) {
    _dio.interceptors.add(
      AuthInterceptor(tokenStorage),
    );
  }

  Future<Response> getRequest(
      String endpoint, {
        bool requiresToken = false,
      }) async {
    try {
      return await _dio.get(
        endpoint,
        options: Options(
          extra: {
            'requiresToken': requiresToken,
          },
        ),
      );
    } on DioException catch (e) {
      debugPrint('GET Error: ${e.message}');
      throw ErrorHandler.handle(e);
    }
  }

  Future<Response> postRequest(
      String endpoint,
      Map<String, dynamic> body, {
        bool requiresToken = false,
      }) async {
    try {
      return await _dio.post(
        endpoint,
        data: body,
        options: Options(
          extra: {
            'requiresToken': requiresToken,
          },
        ),
      );
    } on DioException catch (e) {
      debugPrint('POST Error: ${e.message}');
      throw ErrorHandler.handle(e);
    }
  }

  Future<Response> putRequest(
      String endpoint,
      Map<String, dynamic> body, {
        bool requiresToken = false,
      }) async {
    try {
      return await _dio.put(
        endpoint,
        data: body,
        options: Options(
          extra: {
            'requiresToken': requiresToken,
          },
        ),
      );
    } on DioException catch (e) {
      debugPrint('PUT Error: ${e.message}');
      throw ErrorHandler.handle(e);
    }
  }

  Future<Response> deleteRequest(
      String endpoint,
      String id, {
        bool requiresToken = false,
      }) async {
    try {
      return await _dio.delete(
        '$endpoint/$id/',
        options: Options(
          extra: {
            'requiresToken': requiresToken,
          },
        ),
      );
    } on DioException catch (e) {
      debugPrint('DELETE Error: ${e.message}');
      throw ErrorHandler.handle(e);
    }
  }

  Future<Response> postFormData(
      String endpoint,
      Map<String, dynamic> body, {
        bool requiresToken = false,
      }) async {
    try {
      final formData = FormData.fromMap(body);

      return await _dio.post(
        endpoint,
        data: formData,
        options: Options(
          extra: {
            'requiresToken': requiresToken,
          },
        ),
      );
    } on DioException catch (e) {
      debugPrint('POST FORM DATA Error: ${e.message}');
      throw ErrorHandler.handle(e);
    }
  }

  Future<Response> putFormData(
      String endpoint,
      Map<String, dynamic> body, {
        bool requiresToken = false,
      }) async {
    try {
      final formData = FormData.fromMap(body);

      return await _dio.put(
        endpoint,
        data: formData,
        options: Options(
          extra: {
            'requiresToken': requiresToken,
          },
        ),
      );
    } on DioException catch (e) {
      debugPrint('PUT FORM DATA Error: ${e.message}');
      throw ErrorHandler.handle(e);
    }
  }
}