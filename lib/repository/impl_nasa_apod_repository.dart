import 'dart:convert';

import 'package:hello_universe/api/models/apod.dart';
import 'package:hello_universe/network/http_client.dart';
import 'package:hello_universe/network/properties.dart';
import 'package:hello_universe/repository/nasa_apod_repository.dart';
import 'package:http/http.dart';

/// Real implementation of [NasaApodRepository] interface.
class ImplNasaApodRepository extends NasaApodRepository {
  static const String _baseNasaApiUrl = 'api.nasa.gov';
  static const String _ApodPath = '/planetary/apod';
  static final HttpClient _client = HttpClient(Client());

  @override
  Future<PictureOfDay> fetchPictureOfDay() async {
    try {
      /// Get a valid key from Nasa API website (https://api.nasa.gov/) or
      /// use the demo key [DEMO_KEY].
      final Map<String, String> parameterQueries = {'api_key': NASA_API_KEY};
      final Response response = await _client.request(
        authority: _baseNasaApiUrl,
        path: _ApodPath,
        parameter: parameterQueries,
      );

      if (response.statusCode == 200) {
        return PictureOfDay.fromJson(jsonDecode(response.body));
      } else {
        return throw Exception(
            'Apod is not available. Response status code is: ${response.statusCode}');
      }
    } catch (error) {
      return throw Exception('Something went wrong! $error');
    }
  }
}
