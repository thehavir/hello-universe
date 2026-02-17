import 'package:hello_universe/src/data/models/apod_dto.dart';
import 'package:hello_universe/src/data/models/media_type_dto.dart';

abstract final class TestModels {
  static ApodDto apod({
    String? copyright,
    String? date,
    String? explanation,
    String? hdUrl,
    MediaTypeDto? mediaType,
    String? serviceVersion,
    String? title,
    String? url,
    String? thumbnailUrl,
  }) => ApodDto(
    (b) => b
      ..copyright = copyright
      ..date = date
      ..explanation = explanation
      ..hdUrl = hdUrl
      ..mediaType = mediaType
      ..serviceVersion = serviceVersion
      ..title = title
      ..url = url
      ..thumbnailUrl = thumbnailUrl,
  );
}
