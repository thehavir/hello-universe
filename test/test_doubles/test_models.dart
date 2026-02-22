import 'package:hello_universe/src/data/models/apod_dto.dart';
import 'package:hello_universe/src/data/models/media_type_dto.dart';
import 'package:hello_universe/src/domain/apod_page.dart';
import 'package:hello_universe/src/domain/apods_error.dart';
import 'package:hello_universe/src/domain/apods_page_key.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/domain/entities/media_type.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_data.dart';

abstract final class TestModels {
  static ApodDto apodDto({
    String? date,
    String? title,
    String? explanation,
    MediaTypeDto? mediaType,
    String? hdUrl,
    String? url,
    String? thumbnailUrl,
    String? copyright,
    String? serviceVersion,
  }) => ApodDto(
    (b) => b
      ..date = date ?? '2030-01-25'
      ..title = title ?? 'title-test1'
      ..explanation = explanation ?? 'explanation-test1'
      ..mediaType = mediaType ?? .image
      ..url = url ?? 'url-test1'
      ..hdUrl = hdUrl
      ..thumbnailUrl = thumbnailUrl
      ..copyright = copyright
      ..serviceVersion = serviceVersion ?? 'serviceVersion-test1',
  );

  static Apod apod({
    DateTime? date,
    String? title,
    String? explanation,
    MediaType? mediaType,
    String? hdUrl,
    String? url,
    String? thumbnailUrl,
    String? copyright,
    String? serviceVersion,
  }) => Apod(
    date: date ?? DateTime(2030, 01, 25),
    title: title ?? 'title-test1',
    explanation: explanation ?? 'explanation-test1',
    mediaType: mediaType ?? .image,
    url: url ?? 'url-test1',
    hdUrl: hdUrl,
    thumbnailUrl: thumbnailUrl,
    copyright: copyright,
    serviceVersion: serviceVersion ?? 'serviceVersion-test1',
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

  static ApodsListData apodsData({
    List<List<Apod>>? apodPages,
    List<ApodsPageKey>? apodPageKeys,
    bool? hasNextPage,
  }) => ApodsListData(
    apodPages:
        apodPages ??
        [
          [apod()],
        ],
    apodPageKeys: apodPageKeys ?? [apodsPageKey()],
    hasNextPage: hasNextPage ?? true,
  );
}
