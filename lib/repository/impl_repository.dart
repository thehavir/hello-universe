import 'dart:convert';

/// This file contains Nasa API key.
/// Get a valid key from Nasa API website (https://api.nasa.gov/) or
/// use the demo key `DEMO_KEY`.
import 'package:hello_universe/keys.dart';
import 'package:hello_universe/models/model.dart';
import 'package:hello_universe/repository/base_repository.dart';
import 'package:hello_universe/utils/network/network.dart';
import 'package:http/http.dart';

/// Real implementation of [BaseRepository] interface.
class ImplRepository extends BaseRepository {
  static const String _baseNasaApiUrl = 'api.nasa.gov';
  static const String _apodPath = '/planetary/apod';
  static final HttpClient _client = HttpClient(Client());

  @override
  Future<PictureOfDay> fetchPictureOfDay({String? date}) async {
    try {
      /// Get a valid key from Nasa API website (https://api.nasa.gov/) or
      /// use the demo key [DEMO_KEY].
      final Map<String, String> parameterQueries = <String, String>{
        'api_key': NASA_API_KEY,
        'thumbs': 'True',
        if (date != null) 'date': date,
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
            'APOD is not available. Response status code is: ${response.body}');
      }
    } on Exception catch (error) {
      return throw Exception('Something went wrong on fetching APOD! $error');
    }
  }

  @override
  Future<List<PictureOfDay>> fetchImageList({
    required String startDate,
    required String endDate,
  }) async {
    try {
      final Map<String, String> parameterQueries = <String, String>{
        'api_key': NASA_API_KEY,
        // The order of start/end dates is not what we want. So dates will be
        // sent in the opposite order.
        'start_date': endDate,
        'end_date': startDate,
        'thumbs': 'True',
      };
      final Response response = await _client.request(
        authority: _baseNasaApiUrl,
        path: _apodPath,
        parameter: parameterQueries,
      );

      if (response.statusCode == 200) {
        final Iterable<dynamic> decodedJsonList =
            json.decode(response.body);

        return List<PictureOfDay>.from(
          decodedJsonList.map<PictureOfDay>(
              (dynamic model) => PictureOfDay.fromJson(model)),
          // We want a list with the opposite order of what we get from the API,
          // so, we return the reversed list.
        ).reversed.toList();
      } else {
        return throw Exception(
            'APOD list is not available. Response body is: ${response.body}');
      }
    } on Exception catch (error) {
      return throw Exception(
          'Something went wrong on fetching APOD list! $error');
    }
  }
}
