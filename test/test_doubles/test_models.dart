import 'package:hello_universe/src/data/models/apod_dto.dart';
import 'package:hello_universe/src/data/models/media_type_dto.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/domain/entities/media_type.dart';

abstract final class TestModels {
  static ApodDto apodDto({
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

  static Apod apod({
    String? copyright,
    DateTime? date,
    String? explanation,
    String? hdUrl,
    MediaType? mediaType,
    String? serviceVersion,
    String? title,
    String? url,
    String? thumbnailUrl,
  }) => Apod(
    date: date,
    title: title,
    explanation: explanation,
    copyright: copyright,
    serviceVersion: serviceVersion,
    url: url,
    hdUrl: hdUrl,
    thumbnailUrl: thumbnailUrl,
    mediaType: mediaType,
  );
}
