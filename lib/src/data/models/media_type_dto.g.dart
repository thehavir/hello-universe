// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_type_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MediaTypeDto _$image = const MediaTypeDto._('image');
const MediaTypeDto _$video = const MediaTypeDto._('video');
const MediaTypeDto _$other = const MediaTypeDto._('other');

MediaTypeDto _$valueOf(String name) {
  switch (name) {
    case 'image':
      return _$image;
    case 'video':
      return _$video;
    case 'other':
      return _$other;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MediaTypeDto> _$values = BuiltSet<MediaTypeDto>(
  const <MediaTypeDto>[_$image, _$video, _$other],
);

Serializer<MediaTypeDto> _$mediaTypeDtoSerializer = _$MediaTypeDtoSerializer();

class _$MediaTypeDtoSerializer implements PrimitiveSerializer<MediaTypeDto> {
  @override
  final Iterable<Type> types = const <Type>[MediaTypeDto];
  @override
  final String wireName = 'MediaTypeDto';

  @override
  Object serialize(
    Serializers serializers,
    MediaTypeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) => object.name;

  @override
  MediaTypeDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => MediaTypeDto.valueOf(serialized as String);
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
