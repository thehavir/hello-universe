// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'apod_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ApodService extends ApodService {
  _$ApodService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ApodService;

  @override
  Future<Response<Apod>> fetchImage({
    required String apiKey,
    required bool includeThumbnails,
  }) {
    final Uri $url = Uri.parse('/planetary/apod');
    final Map<String, dynamic> $params = <String, dynamic>{
      'api_key': apiKey,
      'thumbs': includeThumbnails,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Apod, Apod>($request);
  }

  @override
  Future<Response<BuiltList<Apod>>> fetchImageList({
    required String apiKey,
    required String startDate,
    required String endDate,
    required bool includeThumbnails,
  }) {
    final Uri $url = Uri.parse('/planetary/apod');
    final Map<String, dynamic> $params = <String, dynamic>{
      'api_key': apiKey,
      'start_date': startDate,
      'end_date': endDate,
      'thumbs': includeThumbnails,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BuiltList<Apod>, Apod>($request);
  }
}
