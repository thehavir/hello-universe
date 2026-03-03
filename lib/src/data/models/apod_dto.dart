library apod;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hello_universe/src/data/models/media_type_dto.dart';
import 'package:hello_universe/src/data/serializer.dart';

part 'apod_dto.g.dart';

abstract class ApodDto implements Built<ApodDto, ApodDtoBuilder> {
  factory ApodDto([void Function(ApodDtoBuilder) updates]) = _$ApodDto;

  ApodDto._();

  /// Date of the APOD.
  ///
  /// Format: YYYY-MM-DD.
  String get date;

  String get title;

  String get explanation;

  @BuiltValueField(wireName: 'media_type')
  MediaTypeDto get mediaType;

  /// It is possible in some cases [url] is null, for example when
  /// [MediaTypeDto] is [MediaTypeDto.other].
  ///   Exapmle:
  ///      Nasa page: http://apod.nasa.gov/apod/ap241023.html
  ///      Complete request: https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&thumbs=true&date=2024-10-23
  String? get url;

  @BuiltValueField(wireName: 'hdurl')
  String? get hdUrl;

  /// Thumbnail url for videos.
  /// Possible values when [MediaTypeDto] is [MediaTypeDto.video]:
  ///   - Url.
  ///     Exapmle:
  ///        Nasa page: https://apod.nasa.gov/apod/ap240630.html
  ///        Complete request: https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&thumbs=true&date=2024-06-30
  ///        JSON response: "thumbnail_url": "https://img.youtube.com/vi/1R5QqhPq1Ik/0.jpg",
  ///   - Empty string.
  ///     Example:
  ///        Nasa page: https://apod.nasa.gov/apod/ap260113.html
  ///        Complete request: https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&thumbs=true&date=2026-01-13
  ///        JSON response: "thumbnail_url": ""
  ///
  /// For other [MediaTypeDto]s, [thumbnailUrl] is null.
  @BuiltValueField(wireName: 'thumbnail_url')
  String? get thumbnailUrl;

  /// It is null when the image is public domain.
  String? get copyright;

  @BuiltValueField(wireName: 'service_version')
  String get serviceVersion;

  static Serializer<ApodDto> get serializer => _$apodDtoSerializer;

  Map<String, dynamic>? toJson() =>
      serializers.serializeWith(ApodDto.serializer, this)
          as Map<String, dynamic>?;

  static ApodDto? fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(ApodDto.serializer, json);
}
