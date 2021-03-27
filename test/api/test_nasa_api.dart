import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/api/models/apod.dart';
import 'package:hello_universe/repository/impl_nasa_apod_repository.dart';
import 'package:hello_universe/repository/nasa_apod_repository.dart';

void main() {
  group('Test fetching image (APOD)', () {
    NasaApodRepository nasaApodRepository;

    setUp(() {
      nasaApodRepository = ImplNasaApodRepository();
    });

    test('Test fetch image successful', () async {
      final PictureOfDay pictureOfDay =
          await nasaApodRepository.fetchPictureOfDay();

      expect(pictureOfDay.url, isNotNull);
    });

    tearDown(() {
      nasaApodRepository = null;
    });
  });
}
