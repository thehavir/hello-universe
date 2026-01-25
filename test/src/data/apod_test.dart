import 'package:hello_universe/src/data/apod.dart';
import 'package:hello_universe/src/data/media_type.dart';
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

  test('can be crated', () {
    final tested = Apod();

    expect(tested, isA<Apod>());
  });

  test('sets fields usings its builder', () {
    final tested = Apod(
      (builder) => builder
        ..copyright = 'copyright1'
        ..date = 'date1'
        ..explanation = 'explanation1'
        ..hdUrl = 'hdUrl1'
        ..mediaType = MediaType.video
        ..serviceVersion = 'serviceVersion1'
        ..title = 'title1'
        ..url = 'url1'
        ..thumbnailUrl = 'thumbnailUrl1',
    );

    expect(
      tested,
      isA<Apod>()
          .having((p) => p.copyright, 'copyright', 'copyright1')
          .having((p) => p.date, 'date', 'date1')
          .having((p) => p.explanation, 'explanation', 'explanation1')
          .having((p) => p.hdUrl, 'hdUrl', 'hdUrl1')
          .having((p) => p.mediaType, 'mediaType', MediaType.video)
          .having((p) => p.serviceVersion, 'serviceVersion', 'serviceVersion1')
          .having((p) => p.title, 'title', 'title1')
          .having((p) => p.url, 'url', 'url1')
          .having((p) => p.thumbnailUrl, 'thumbnailUrl', 'thumbnailUrl1'),
    );
  });

  test('toJson creates a map from $Apod', () {
    final json = apod.toJson();

    expect(json, serializedApod);
  });

  test('fromJson creates an $Apod from a map', () {
    final result = Apod.fromJson(serializedApod);

    expect(result, apod);
  });
}
