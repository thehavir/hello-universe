library media_type;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'media_type_dto.g.dart';

final class MediaTypeDto extends EnumClass {
  const MediaTypeDto._(super.name);

  static const MediaTypeDto image = _$image;

  static const MediaTypeDto video = _$video;

  static const MediaTypeDto other = _$other;

  static BuiltSet<MediaTypeDto> get values => _$values;

  static MediaTypeDto valueOf(String name) => _$valueOf(name);

  static Serializer<MediaTypeDto> get serializer => _$mediaTypeDtoSerializer;
}
