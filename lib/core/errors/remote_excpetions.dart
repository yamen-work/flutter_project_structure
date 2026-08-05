import 'package:dio/dio.dart';
import 'error_code.dart';

class RemoteExceptions implements Exception {
  final ErrorCode errorCode;
  final String errorMsg;
  final Response? response;

  const RemoteExceptions(
      this.errorCode,
      this.errorMsg, {
        this.response,
      });

  @override
  String toString() {
    return 'RemoteExceptions(errorCode: $errorCode, errorMsg: $errorMsg)';
  }
}