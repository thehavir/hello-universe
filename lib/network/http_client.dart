import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_universe/network/request_exception.dart';
import 'package:hello_universe/network/request_type.dart';
import 'package:http/http.dart';

/// This is a wrapper for [Client] that removes boilerplate code of creating a
/// http request. It creates an http Uri and returns a [Response] based on the
/// parameters that client is provided.
class HttpClient {
  final Client client;

  const HttpClient(this.client);

  Future<Response> request({
    RequestType requestType = RequestType.GET,
    @required String authority,
    @required String path,
    Map<String, String> parameter,
  }) async {
    switch (requestType) {
      case RequestType.GET:
        return client.get(Uri.https(authority, path, parameter));
      case RequestType.POST:
        return client.post(
          Uri.https(authority, path),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(parameter),
        );
      case RequestType.DELETE:
        return client.delete(Uri.https(authority, path));
      default:
        return throw RequestTypeNotFoundException(
            'The HTTP request method is not found: $requestType');
    }
  }
}
