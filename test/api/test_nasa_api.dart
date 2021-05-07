import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/api/models/apod.dart';
import 'package:hello_universe/repository/impl_nasa_apod_repository.dart';
import 'package:hello_universe/repository/nasa_apod_repository.dart';

void main() {
  group('Test fetching image', () {
    NasaApodRepository nasaApodRepository;

    setUp(() {
      nasaApodRepository = ImplNasaApodRepository();
    });

    test('Test fetch image (APOD) successful', () async {
      final PictureOfDay pictureOfDay =
          await nasaApodRepository.fetchPictureOfDay();

      expect(pictureOfDay.url, isNotNull);
    });

    test('Test fetch image list successful', () async {
      final List<PictureOfDay> imageList =
          await nasaApodRepository.fetchImageList(
        startDate: '2016-01-25',
        endDate: '2016-02-25',
      );

      expect(imageList.length, 32);
    });

    tearDown(() {
      nasaApodRepository = null;
    });
  });
}
