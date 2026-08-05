import 'error_messages.dart';

enum ErrorCode {
  // HTTP Errors
  BAD_REQUEST,
  UNAUTHENTICATED,
  FORBIDDEN,
  NOT_FOUND,
  UNPROCESSABLE_ENTITY,
  SERVER_ERROR,

  // Network Errors
  NO_INTERNET_CONNECTION,
  TIMEOUT,
  CANCEL,
  BAD_CERTIFICATE,

  // Business Errors
  PENDING_APPROVAL,
  NOT_EXIST_ACCOUNT,
  EXIST,

  // Application Errors
  APP_ERROR,
  USER_DATA_NOT_FOUND,
  UNKNOWN,
}

extension ErrorCodeLocalization on ErrorCode {
  String getLocalizedMessage() {
    final messages =  errorMessages['en']!;
    return messages[this] ??
        messages[ErrorCode.UNKNOWN]!;
  }
}