// ignore_for_file: avoid_redundant_argument_values

import 'package:hello_universe/src/data/models/apod_dto.dart';
import 'package:hello_universe/src/data/models/apod_dto_extension.dart';
import 'package:hello_universe/src/data/models/media_type_dto.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:test/test.dart';

import '../../../test_doubles/test_models.dart';

void main() {
  test('toEntity maps $ApodDto to $Apod', () {
    const copyright = 'GPG-3';
    const date = '2010-05-18';
    const explanation = 'Earth from outside';
    const title = 'Blue pale dot';
    const mediaType = MediaTypeDto.image;
    const serviceVersion = 'v114.7825';
    const url = 'https://www.nasa.org/image1';
    const hdUrl = 'https://www.nasa.org/image1-hd';
    const thumbnailUrl = 'https://www.nasa.org/image1-thumbnail';
    final dto = TestModels.apodDto(
      date: date,
      title: title,
      explanation: explanation,
      copyright: copyright,
      mediaType: mediaType,
      url: url,
      hdUrl: hdUrl,
      thumbnailUrl: thumbnailUrl,
      serviceVersion: serviceVersion,
    );

    final entity = dto.toEntity();

    expect(
      entity,
      Apod(
        date: DateTime(2010, 05, 18),
        title: title,
        explanation: explanation,
        copyright: copyright,
        mediaType: .image,
        url: url,
        hdUrl: hdUrl,
        thumbnailUrl: thumbnailUrl,
        serviceVersion: serviceVersion,
      ),
    );
  });

  test('toEntity maps $ApodDto to $Apod with null date when it is null', () {
    final dto = TestModels.apodDto(date: null);

    final entity = dto.toEntity();

    expect(entity, isA<Apod>().having((p) => p.date, 'date', isNull));
  });
}
