import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hello_universe/api/models/apod.dart';
import 'package:hello_universe/network/http_client.dart';
import 'package:hello_universe/network/properties.dart';
import 'package:hello_universe/repository/nasa_apod_repository.dart';
import 'package:http/http.dart';

/// Real implementation of [NasaApodRepository] interface.
class ImplNasaApodRepository extends NasaApodRepository {
  static const String _baseNasaApiUrl = 'api.nasa.gov';
  static const String _apodPath = '/planetary/apod';
  static final HttpClient _client = HttpClient(Client());

  @override
  Future<PictureOfDay> fetchPictureOfDay() async {
    try {
      /// Get a valid key from Nasa API website (https://api.nasa.gov/) or
      /// use the demo key [DEMO_KEY].
      final Map<String, String> parameterQueries = {
        'api_key': NASA_API_KEY,
      };
      final Response response = await _client.request(
        authority: _baseNasaApiUrl,
        path: _apodPath,
        parameter: parameterQueries,
      );

      if (response.statusCode == 200) {
        return PictureOfDay.fromJson(jsonDecode(response.body));
      } else {
        return throw Exception(
            'APOD is not available. Response status code is: ${response.statusCode}');
      }
    } catch (error) {
      return throw Exception('Something went wrong on fetching APOD! $error');
    }
  }

  @override
  Future<List<PictureOfDay>> fetchImageList({
    @required String startDate,
    @required String endDate,
  }) async {
    try {
      final Map<String, String> parameterQueries = {
        'api_key': NASA_API_KEY,
        'start_date': startDate,
        'end_date': endDate,
        'thumbs': 'True',
      };
      final Response response = await _client.request(
        authority: _baseNasaApiUrl,
        path: _apodPath,
        parameter: parameterQueries,
      );

      if (response.statusCode == 200) {
        final Iterable decodedJsonList = json.decode(response.body);
        return List<PictureOfDay>.from(
          decodedJsonList.map((model) => PictureOfDay.fromJson(model)),
        );
      } else {
        return throw Exception(
            'APOD list is not available. Response status code is: ${response.statusCode}');
      }
    } catch (error) {
      return throw Exception(
          'Something went wrong on fetching APOD list! $error');
    }
  }
}
