import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/features/image_list/extensions/extensions.dart';
import 'package:hello_universe/src/repository/base_repository.dart';
import 'package:hello_universe/src/repository/impl_repository.dart';

void main() {
  group('Test fetching image', () {
    late BaseRepository nasaApodRepository;

    // There is no exact time for update APOD from NASA each day, so we always
    // fetch the yesterday APOD as the first APOD.
    final now = DateTime.now().xDaysBefore(1);
    final xDaysBefore = now.xDaysBefore();
    final startDate = now.format();
    final endDate = xDaysBefore.format();

    setUp(() {
      nasaApodRepository = ImplRepository();
    });

    test('Test fetch image (APOD) successful', () async {
      final apod = await nasaApodRepository.fetchApod();

      expect(apod.url, isNotNull);
    });

    test('Test fetch image list successful', () async {
      final imageList = await nasaApodRepository.fetchImageList(
        startDate: '2016-02-25',
        endDate: '2016-01-25',
      );

      expect(imageList.length, 32);
    });

    test('Test fetch image list in boundaries successful', () async {
      final imageList = await nasaApodRepository.fetchImageList(
        startDate: '1995-06-27',
        endDate: '1995-06-20',
      );

      expect(imageList.length, 8);

      final imageList2 = await nasaApodRepository.fetchImageList(
        startDate: '1995-06-27',
        endDate: '1995-06-16',
      );

      expect(imageList2.length, 9);

      final imageList3 = await nasaApodRepository.fetchImageList(
        startDate: '1995-06-16',
        endDate: '1995-06-16',
      );

      expect(imageList3.length, 1);
      final imageList4 = await nasaApodRepository.fetchImageList(
        startDate: '1995-06-20',
        endDate: '1995-06-17',
      );

      expect(imageList4.length, 1);
    });

    test('Test fetch image list in boundaries failure', () async {
      expect(
        () => nasaApodRepository.fetchImageList(
          startDate: '1995-06-27',
          endDate: '1995-06-15',
        ),
        throwsException,
      );
    });

    test(
      'Test fetch image list successful between now till 19 days ago',
      () async {
        final imageList = await nasaApodRepository.fetchImageList(
          startDate: startDate,
          endDate: endDate,
        );

        expect(imageList.length, 21);
      },
    );

    test('Test order of the image list', () async {
      final imageList = await nasaApodRepository.fetchImageList(
        startDate: startDate,
        endDate: endDate,
      );

      expect(imageList.length, 21);

      expect(imageList[0].date, now.xDaysBefore(20 - 20).format());
    });

    test('Test fetch Apod of a specific date', () async {
      final apod = await nasaApodRepository.fetchApod(date: '2016-02-06');

      expect(apod.url, isNotNull);
    });

    test('Test thumbnail url is not null for Apod videos', () async {
      final apod = await nasaApodRepository.fetchApod(date: '2016-02-09');

      expect(apod.thumbnailUrl, isNotNull);
    });
  });
}
