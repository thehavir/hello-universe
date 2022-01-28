import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/features/image_list/extensions/extensions.dart';
import 'package:hello_universe/models/models.dart';
import 'package:hello_universe/repository/base_repository.dart';
import 'package:hello_universe/repository/impl_repository.dart';

void main() {
  group('Test fetching image', () {
    late BaseRepository nasaApodRepository;

    // There is no exact time for update APOD from NASA each day, so we always
    // fetch the yesterday APOD as the first APOD.
    final DateTime now = DateTime.now().xDaysBefore(1);
    final DateTime xDaysBefore = now.xDaysBefore();
    final String startDate = now.format();
    final String endDate = xDaysBefore.format();

    setUp(() {
      nasaApodRepository = ImplRepository();
    });

    test('Test fetch image (APOD) successful', () async {
      final Apod apod =
          await nasaApodRepository.fetchApod();

      expect(apod.url, isNotNull);
    });

    test('Test fetch image list successful', () async {
      final List<Apod> imageList =
          await nasaApodRepository.fetchImageList(
        startDate: '2016-02-25',
        endDate: '2016-01-25',
      );

      expect(imageList.length, 32);
    });

    test('Test fetch image list in boundaries successful', () async {
      final List<Apod> imageList =
          await nasaApodRepository.fetchImageList(
        startDate: '1995-06-27',
        endDate: '1995-06-20',
      );

      expect(imageList.length, 8);

      final List<Apod> imageList2 =
          await nasaApodRepository.fetchImageList(
        startDate: '1995-06-27',
        endDate: '1995-06-16',
      );

      expect(imageList2.length, 9);

      final List<Apod> imageList3 =
          await nasaApodRepository.fetchImageList(
        startDate: '1995-06-16',
        endDate: '1995-06-16',
      );

      expect(imageList3.length, 1);
      final List<Apod> imageList4 =
          await nasaApodRepository.fetchImageList(
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

    test('Test fetch image list successful between now till 19 days ago',
        () async {
      final List<Apod> imageList =
          await nasaApodRepository.fetchImageList(
        startDate: startDate,
        endDate: endDate,
      );

      expect(imageList.length, 21);
    });

    test('Test order of the image list', () async {
      final List<Apod> imageList =
          await nasaApodRepository.fetchImageList(
        startDate: startDate,
        endDate: endDate,
      );

      expect(imageList.length, 21);

      expect(imageList[0].date, now.xDaysBefore(20 - 20).format());
    });

    test('Test fetch Apod of a specific date', () async {
      final Apod apod =
          await nasaApodRepository.fetchApod(date: '2016-02-06');

      expect(apod.url, isNotNull);
    });

    test('Test thumbnail url is not null for Apod videos', () async {
      final Apod apod =
          await nasaApodRepository.fetchApod(date: '2016-02-09');

      expect(apod.thumbnailUrl, isNotNull);
    });
  });
}
