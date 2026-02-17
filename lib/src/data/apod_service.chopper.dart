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
  Future<ApodDto> fetchImage({required bool includeThumbnails}) async {
    final Uri $url = Uri.parse('/planetary/apod');
    final Map<String, dynamic> $params = <String, dynamic>{
      'thumbs': includeThumbnails,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    final Response $response = await client.send<ApodDto, ApodDto>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<BuiltList<ApodDto>> fetchImageList({
    required String startDate,
    required String endDate,
    required bool includeThumbnails,
  }) async {
    final Uri $url = Uri.parse('/planetary/apod');
    final Map<String, dynamic> $params = <String, dynamic>{
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
    final Response $response = await client.send<BuiltList<ApodDto>, ApodDto>(
      $request,
    );
    return $response.bodyOrThrow;
  }
}
