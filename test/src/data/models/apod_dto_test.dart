import 'package:hello_universe/src/data/models/apod_dto.dart';
import 'package:hello_universe/src/data/models/media_type_dto.dart';
import 'package:test/test.dart';

import '../../../test_doubles/test_models.dart';

void main() {
  const date = '2010-05-18';
  const title = 'Blue pale dot';
  const explanation = 'Earth from outside';
  const mediaType = MediaTypeDto.image;
  const url = 'https://www.nasa.org/image1';
  const hdUrl = 'https://www.nasa.org/image1-hd';
  const thumbnailUrl = 'https://www.nasa.org/image1-thumbnail';
  const copyright = 'GPG-3';
  const serviceVersion = 'v114.7825';
  final apod = TestModels.apodDto(
    date: date,
    title: title,
    explanation: explanation,
    mediaType: mediaType,
    url: url,
    hdUrl: hdUrl,
    thumbnailUrl: thumbnailUrl,
    copyright: copyright,
    serviceVersion: serviceVersion,
  );
  final serializedApod = {
    'date': date,
    'title': title,
    'explanation': explanation,
    'media_type': mediaType.name,
    'url': url,
    'hdurl': hdUrl,
    'thumbnail_url': thumbnailUrl,
    'copyright': copyright,
    'service_version': serviceVersion,
  };

  test('can be crated', () {
    final tested = TestModels.apodDto();

    expect(tested, isA<ApodDto>());
  });

  test('toJson creates a map from $ApodDto', () {
    final json = apod.toJson();

    expect(json, serializedApod);
  });

  test('fromJson creates an $ApodDto from a map', () {
    final result = ApodDto.fromJson(serializedApod);

    expect(result, apod);
  });
}
