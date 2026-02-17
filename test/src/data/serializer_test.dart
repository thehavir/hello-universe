import 'package:hello_universe/src/data/models/apod_dto.dart';
import 'package:hello_universe/src/data/models/media_type_dto.dart';
import 'package:hello_universe/src/data/serializer.dart';
import 'package:test/test.dart';

void main() {
  final apod = ApodDto(
    (builder) => builder
      ..copyright = '@zx11'
      ..date = '11/11/2030'
      ..explanation = 'awesome image'
      ..hdUrl = 'xyz.com/image2'
      ..mediaType = MediaTypeDto.image
      ..serviceVersion = '1.33.5811'
      ..title = 'title-z5'
      ..url = 'xyz.com'
      ..thumbnailUrl = 'xyz.com/thumbnail',
  );
  final serializedApod = {
    'copyright': '@zx11',
    'date': '11/11/2030',
    'explanation': 'awesome image',
    'hdurl': 'xyz.com/image2',
    'media_type': 'image',
    'service_version': '1.33.5811',
    'title': 'title-z5',
    'url': 'xyz.com',
    'thumbnail_url': 'xyz.com/thumbnail',
  };

  group('$ApodDto', () {
    test('serializes $ApodDto to a map', () {
      final serialized = serializers.serializeWith(ApodDto.serializer, apod);

      expect(serialized, serializedApod);
    });

    test('deserialized $ApodDto from a map', () {
      final deserialized = serializers.deserializeWith(
        ApodDto.serializer,
        serializedApod,
      );

      expect(deserialized, apod);
    });
  });

  group('$MediaTypeDto', () {
    <MediaTypeDto, String>{
      MediaTypeDto.image: 'image',
      MediaTypeDto.video: 'video',
      MediaTypeDto.other: 'other',
    }.forEach((type, value) {
      test('serializes $type into $value', () {
        final serialized = serializers.serializeWith(
          MediaTypeDto.serializer,
          type,
        );
        expect(serialized, value);
      });

      test('deserialized $value into $type', () {
        final deserialized = serializers.deserializeWith(
          MediaTypeDto.serializer,
          value,
        );
        expect(deserialized, type);
      });
    });
  });
}
