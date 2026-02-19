import 'package:hello_universe/src/data/models/apod_dto.dart';
import 'package:hello_universe/src/data/models/media_type_dto.dart';
import 'package:hello_universe/src/domain/apod_page.dart';
import 'package:hello_universe/src/domain/apods_error.dart';
import 'package:hello_universe/src/domain/apods_page_key.dart';
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

  static ApodsPageKey apodsPageKey({
    DateTime? startDate,
    DateTime? endDate,
    bool? isLastPage,
  }) => ApodsPageKey(
    startDate: startDate ?? DateTime(2020, 05, 26),
    endDate: endDate ?? DateTime(2020, 05, 06),
    isLastPage: isLastPage ?? false,
  );

  static ApodPage apodPage({List<Apod>? apods, ApodsPageKey? pageKey}) =>
      ApodPage(apods: apods ?? [], pageKey: pageKey ?? apodsPageKey());

  static ApodsError apodsError({Object? error}) =>
      ApodsError(error ?? 'error', StackTrace.current);
}
