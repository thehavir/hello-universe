class RequestTypeNotFoundException implements Exception {
  final String message;

  RequestTypeNotFoundException([this.message = 'Invalid request type.']);

  @override
  String toString() => message;
}
