import 'dart:convert';
import 'package:hello_universe/utils/network/network.dart';
import 'package:http/http.dart';

/// This is a wrapper for [Client] that removes boilerplate and duplicate code
/// of creating a http request. It creates an http Uri and returns a [Response]
/// based on the parameters that client has provided.
class HttpClient {
  /// Constructs a `HttpClient`.
  const HttpClient(this.client);

  /// `Client` that `HttpClient` class need it in order to make a http request.
  final Client client;

  /// Send a http request.
  Future<Response> request({
    required String? authority,
    required String? path,
    Map<String, String>? parameter,
    RequestType requestType = RequestType.get,
  }) async {
    switch (requestType) {
      case RequestType.get:
        return client.get(Uri.https(authority!, path!, parameter));
      case RequestType.post:
        return client.post(
          Uri.https(authority!, path!),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(parameter),
        );
      case RequestType.delete:
        return client.delete(Uri.https(authority!, path!));
      default:
        return throw RequestTypeNotFoundException(
            'The HTTP request method is not found: $requestType');
    }
  }
}
