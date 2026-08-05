import 'package:dio/dio.dart';
import 'error_code.dart';
import 'remote_excpetions.dart';

class ErrorHandler {
  const ErrorHandler._();

  /// Converts any supported exception into a [RemoteExceptions].
  static RemoteExceptions handle(Object error) {
    if (error is RemoteExceptions) {
      return error;
    }

    if (error is DioException) {
      return _handleDio(error);
    }

    // Future extensions:
    //
    // if (error is FirebaseException) {
    //   return _handleFirebase(error);
    // }
    //
    // if (error is SocketException) {
    //   return _handleSocket(error);
    // }

    return RemoteExceptions(
      ErrorCode.APP_ERROR,
      ErrorCode.APP_ERROR.getLocalizedMessage(),
    );
  }

  /// Handles all Dio exceptions.
  static RemoteExceptions _handleDio(DioException e) {
    final response = e.response;

    // Server responded with an HTTP status code.
    if (response != null) {
      return _fromResponse(response);
    }

    // No response received. Usually a connection issue.
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return RemoteExceptions(
          ErrorCode.TIMEOUT,
          ErrorCode.TIMEOUT.getLocalizedMessage(),
        );

      case DioExceptionType.connectionError:
        return RemoteExceptions(
          ErrorCode.NO_INTERNET_CONNECTION,
          ErrorCode.NO_INTERNET_CONNECTION.getLocalizedMessage(),
        );

      case DioExceptionType.cancel:
        return RemoteExceptions(
          ErrorCode.CANCEL,
          ErrorCode.CANCEL.getLocalizedMessage(),
        );

      case DioExceptionType.badCertificate:
        return RemoteExceptions(
          ErrorCode.BAD_CERTIFICATE,
          ErrorCode.BAD_CERTIFICATE.getLocalizedMessage(),
        );

      case DioExceptionType.badResponse:
      case DioExceptionType.unknown:
      default:
        return RemoteExceptions(
          ErrorCode.UNKNOWN,
          ErrorCode.UNKNOWN.getLocalizedMessage(),
        );
    }
  }

  /// Converts an HTTP response into a RemoteExceptions.
  static RemoteExceptions _fromResponse(Response response) {
    final errorCode = _mapStatusCode(response.statusCode ?? -1);

    return RemoteExceptions(
      errorCode,
      _extractServerMessage(response) ?? errorCode.getLocalizedMessage(),
      response: response,
    );
  }

  /// Maps HTTP status codes to application error codes.
  static ErrorCode _mapStatusCode(int statusCode) {
    return switch (statusCode) {
      400 => ErrorCode.BAD_REQUEST,
      401 => ErrorCode.UNAUTHENTICATED,
      403 => ErrorCode.FORBIDDEN,
      404 => ErrorCode.NOT_FOUND,
      408 => ErrorCode.TIMEOUT,
      409 => ErrorCode.PENDING_APPROVAL,
      422 => ErrorCode.UNPROCESSABLE_ENTITY,
      426 => ErrorCode.NOT_EXIST_ACCOUNT, // API-specific
      500 || 501 || 502 || 503 || 504 => ErrorCode.SERVER_ERROR,
      _ => ErrorCode.UNKNOWN,
    };
  }

  /// Attempts to extract a readable error message from the server response.
  static String? _extractServerMessage(Response response) {
    final data = response.data;

    if (data is! Map) {
      return null;
    }

    // { "message": "..." }
    if (data['message'] is String) {
      return data['message'] as String;
    }

    // { "error": { "message": "..." } }
    if (data['error'] is Map &&
        data['error']['message'] is String) {
      return data['error']['message'] as String;
    }

    return null;
  }

}