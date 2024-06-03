class CustomException implements Exception {
  final String message;
  final int? code;

  CustomException(this.message, [this.code]);

  @override
  String toString() {
    if (code != null) {
      return 'CustomException: $message (Code: $code)';
    }
    return 'CustomException: $message';
  }
}
class SessionExpiredException implements Exception {
  final String message;
  final int? code;

  SessionExpiredException(this.message, [this.code]);

  @override
  String toString() {
    if (code != null) {
      return 'CustomException: $message (Code: $code)';
    }
    return 'CustomException: $message';
  }
}
