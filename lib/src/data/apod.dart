library apod;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hello_universe/src/data/media_type.dart';
import 'package:hello_universe/src/data/serializer.dart';

part 'apod.g.dart';

abstract class Apod implements Built<Apod, ApodBuilder> {
  factory Apod([void Function(ApodBuilder) updates]) = _$Apod;

  Apod._();

  String? get copyright;

  /// date of the APOD.
  ///
  /// format: YYYY-MM-DD.
  String? get date;

  String? get explanation;

  @BuiltValueField(wireName: 'hdurl')
  String? get hdUrl;

  @BuiltValueField(wireName: 'media_type')
  MediaType? get mediaType;

  @BuiltValueField(wireName: 'service_version')
  String? get serviceVersion;

  String? get title;

  String? get url;

  @BuiltValueField(wireName: 'thumbnail_url')
  String? get thumbnailUrl;

  static Serializer<Apod> get serializer => _$apodSerializer;

  Map<String, dynamic>? toJson() =>
      serializers.serializeWith(Apod.serializer, this) as Map<String, dynamic>?;

  static Apod? fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(Apod.serializer, json);
}
