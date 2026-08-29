import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
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

    if (error is FirebaseException) {
      return _handleFirebase(error);
    }

    return RemoteExceptions(
      ErrorCode.APP_ERROR,
      ErrorCode.APP_ERROR.getLocalizedMessage(),
    );
  }


  static RemoteExceptions _handleDio(DioException e) {
    final response = e.response;

    if (response != null) {
      return _fromResponse(response);
    }

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

  static RemoteExceptions _fromResponse(Response response) {
    final errorCode = _mapStatusCode(
      response.statusCode ?? -1,
    );

    final String errorMessage =
        _extractServerMessage(response) ??
        errorCode.getLocalizedMessage();

    return RemoteExceptions(
      errorCode,
      errorMessage,
      response: response,
    );
  }

  static ErrorCode _mapStatusCode(int statusCode) {
    return switch (statusCode) {
      400 => ErrorCode.BAD_REQUEST,
      401 => ErrorCode.UNAUTHENTICATED,
      403 => ErrorCode.FORBIDDEN,
      404 => ErrorCode.NOT_FOUND,
      408 => ErrorCode.TIMEOUT,
      409 => ErrorCode.PENDING_APPROVAL,
      422 => ErrorCode.UNPROCESSABLE_ENTITY,
      426 => ErrorCode.NOT_EXIST_ACCOUNT,
      500 ||
      501 ||
      502 ||
      503 ||
      504 => ErrorCode.SERVER_ERROR,
      _ => ErrorCode.UNKNOWN,
    };
  }

  static String? _extractServerMessage(Response response) {
    final data = response.data;

    if (data is! Map) {
      return null;
    }

    if (data['message'] is String) {
      return data['message'] as String;
    }

    if (data['error'] is Map &&
        data['error']['message'] is String) {
      return data['error']['message'] as String;
    }

    if (data['error_message'] is String) {
      return data['error_message'] as String;
    }

    return null;
  }

  // FIREBASE
  static RemoteExceptions _handleFirebase(FirebaseException e) {
    switch (e.code) {
      // Firebase Authentication
      case 'invalid-email':
        return RemoteExceptions(
          ErrorCode.INVALID_EMAIL,
          ErrorCode.INVALID_EMAIL.getLocalizedMessage(),
        );

      case 'wrong-password':
        return RemoteExceptions(
          ErrorCode.WRONG_PASSWORD,
          ErrorCode.WRONG_PASSWORD.getLocalizedMessage(),
        );

      case 'email-already-in-use':
        return RemoteExceptions(
          ErrorCode.EMAIL_ALREADY_IN_USE,
          ErrorCode.EMAIL_ALREADY_IN_USE.getLocalizedMessage(),
        );

      case 'weak-password':
        return RemoteExceptions(
          ErrorCode.WEAK_PASSWORD,
          ErrorCode.WEAK_PASSWORD.getLocalizedMessage(),
        );

      case 'user-not-found':
        return RemoteExceptions(
          ErrorCode.NOT_EXIST_ACCOUNT,
          ErrorCode.NOT_EXIST_ACCOUNT.getLocalizedMessage(),
        );

      case 'invalid-credential':
        return RemoteExceptions(
          ErrorCode.UNAUTHENTICATED,
          ErrorCode.UNAUTHENTICATED.getLocalizedMessage(),
        );

      // Firestore
      case 'permission-denied':
        return RemoteExceptions(
          ErrorCode.FORBIDDEN,
          ErrorCode.FORBIDDEN.getLocalizedMessage(),
        );

      case 'not-found':
        return RemoteExceptions(
          ErrorCode.NOT_FOUND,
          ErrorCode.NOT_FOUND.getLocalizedMessage(),
        );

      case 'unauthenticated':
        return RemoteExceptions(
          ErrorCode.UNAUTHENTICATED,
          ErrorCode.UNAUTHENTICATED.getLocalizedMessage(),
        );

      case 'unavailable':
        return RemoteExceptions(
          ErrorCode.NO_INTERNET_CONNECTION,
          ErrorCode.NO_INTERNET_CONNECTION.getLocalizedMessage(),
        );

      default:
        return RemoteExceptions(
          ErrorCode.UNKNOWN,
          e.message ??
              ErrorCode.UNKNOWN.getLocalizedMessage(),
        );
    }
  }
}