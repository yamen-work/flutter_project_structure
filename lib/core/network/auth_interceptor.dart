import 'package:dio/dio.dart';

import '../secure_storage/token_storage_interface.dart';


class AuthInterceptor extends Interceptor {

  final TokenStorage _tokenStorage;

  AuthInterceptor(this._tokenStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final requiresToken = options.extra['requiresToken'] == true;

    if (!requiresToken) {
      handler.next(options);
      return;
    }

    final token = await _tokenStorage.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';

    }

    handler.next(options);
  }
}
