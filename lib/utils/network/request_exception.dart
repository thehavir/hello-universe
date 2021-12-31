/// A custom Exception in order to be thrown when the request type is not valid.
class RequestTypeNotFoundException implements Exception {
  /// Constructs a `RequestTypeNotFoundException`.
  RequestTypeNotFoundException([this.message = 'Invalid request type.']);

  /// Error message.
  final String message;

  @override
  String toString() => message;
}
