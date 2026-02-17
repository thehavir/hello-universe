library apod;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hello_universe/src/data/models/media_type_dto.dart';
import 'package:hello_universe/src/data/serializer.dart';

part 'apod_dto.g.dart';

abstract class ApodDto implements Built<ApodDto, ApodDtoBuilder> {
  factory ApodDto([void Function(ApodDtoBuilder) updates]) = _$ApodDto;

  ApodDto._();

  String? get copyright;

  /// date of the APOD.
  ///
  /// format: YYYY-MM-DD.
  String? get date;

  String? get explanation;

  @BuiltValueField(wireName: 'hdurl')
  String? get hdUrl;

  @BuiltValueField(wireName: 'media_type')
  MediaTypeDto? get mediaType;

  @BuiltValueField(wireName: 'service_version')
  String? get serviceVersion;

  String? get title;

  String? get url;

  @BuiltValueField(wireName: 'thumbnail_url')
  String? get thumbnailUrl;

  static Serializer<ApodDto> get serializer => _$apodDtoSerializer;

  Map<String, dynamic>? toJson() =>
      serializers.serializeWith(ApodDto.serializer, this)
          as Map<String, dynamic>?;

  static ApodDto? fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(ApodDto.serializer, json);
}
