library media_type;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'media_type.g.dart';

final class MediaType extends EnumClass {
  const MediaType._(super.name);

  static const MediaType image = _$image;

  static const MediaType video = _$video;

  static const MediaType other = _$other;

  static BuiltSet<MediaType> get values => _$values;

  static MediaType valueOf(String name) => _$valueOf(name);

  static Serializer<MediaType> get serializer => _$mediaTypeSerializer;
}
