import 'package:hello_universe/src/data/apod.dart';
import 'package:hello_universe/src/data/media_type.dart';
import 'package:hello_universe/src/data/serializer.dart';
import 'package:test/test.dart';

void main() {
  final apod = Apod(
    (builder) => builder
      ..copyright = '@zx11'
      ..date = '11/11/2030'
      ..explanation = 'awesome image'
      ..hdUrl = 'xyz.com/image2'
      ..mediaType = MediaType.image
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

  group('$Apod', () {
    test('serializes $Apod to a map', () {
      final serialized = serializers.serializeWith(Apod.serializer, apod);

      expect(serialized, serializedApod);
    });

    test('deserialized $Apod from a map', () {
      final deserialized = serializers.deserializeWith(
        Apod.serializer,
        serializedApod,
      );

      expect(deserialized, apod);
    });
  });

  group('$MediaType', () {
    <MediaType, String>{
      MediaType.image: 'image',
      MediaType.video: 'video',
      MediaType.other: 'other',
    }.forEach((type, value) {
      test('serializes $type into $value', () {
        final serialized = serializers.serializeWith(
          MediaType.serializer,
          type,
        );
        expect(serialized, value);
      });

      test('deserialized $value into $type', () {
        final deserialized = serializers.deserializeWith(
          MediaType.serializer,
          value,
        );
        expect(deserialized, type);
      });
    });
  });
}
