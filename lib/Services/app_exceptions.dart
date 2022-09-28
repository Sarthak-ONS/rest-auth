class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([this.message, this.prefix, this.url]);
}

class EmailAlreadyExistsException extends AppException {
  EmailAlreadyExistsException([String? message, String? url])
      : super(message, 'Bad request', url);
}

class TooManyAttemptsException extends AppException {
  TooManyAttemptsException([String? message, String? url])
      : super(message, 'Bad request', url);
}

class IntervalServerErrorException extends AppException {
  IntervalServerErrorException([String? message, String? url])
      : super(message, 'Bad request', url);
}
