import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/models/model.dart';
import 'package:hello_universe/repository/base_repository.dart';
import 'package:hello_universe/repository/impl_repository.dart';
import 'package:intl/intl.dart';

void main() {
  group('Test fetching image', () {
    late BaseRepository nasaApodRepository;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final DateTime now = DateTime.now();
    final xDaysBefore = now.subtract(Duration(days: 19));
    final String startDate = formatter.format(now);
    final String endDate = formatter.format(xDaysBefore);

    setUp(() {
      nasaApodRepository = ImplRepository();
    });

    test('Test fetch image (APOD) successful', () async {
      final PictureOfDay pictureOfDay =
          await nasaApodRepository.fetchPictureOfDay();

      expect(pictureOfDay.url, isNotNull);
    });

    test('Test fetch image list successful', () async {
      final List<PictureOfDay> imageList =
          await nasaApodRepository.fetchImageList(
        startDate: '2016-02-25',
        endDate: '2016-01-25',
      );

      expect(imageList.length, 32);
    });

    test('Test fetch image list in boundaries successful', () async {
      final List<PictureOfDay> imageList =
          await nasaApodRepository.fetchImageList(
        startDate: '1995-06-27',
        endDate: '1995-06-20',
      );

      expect(imageList.length, 8);

      final List<PictureOfDay> imageList2 =
          await nasaApodRepository.fetchImageList(
        startDate: '1995-06-27',
        endDate: '1995-06-16',
      );

      expect(imageList2.length, 9);

      final List<PictureOfDay> imageList3 =
          await nasaApodRepository.fetchImageList(
        startDate: '1995-06-16',
        endDate: '1995-06-16',
      );

      expect(imageList3.length, 1);
      final List<PictureOfDay> imageList4 =
          await nasaApodRepository.fetchImageList(
        startDate: '1995-06-20',
        endDate: '1995-06-17',
      );

      expect(imageList4.length, 1);
    });

    test('Test fetch image list in boundaries failure', () async {
      expect(
        () async => await nasaApodRepository.fetchImageList(
          startDate: '1995-06-27',
          endDate: '1995-06-15',
        ),
        throwsException,
      );
    });

    test('Test fetch image list successful between now till 19 days ago',
        () async {
      final List<PictureOfDay> imageList =
          await nasaApodRepository.fetchImageList(
        startDate: startDate,
        endDate: endDate,
      );

      expect(imageList.length, 20);
    });

    test('Test order of the image list', () async {
      final List<PictureOfDay> imageList = await nasaApodRepository
          .fetchImageList(startDate: startDate, endDate: endDate);

      expect(imageList.length, 20);

      expect(imageList[0].date,
          formatter.format(now.subtract(Duration(days: 19 - 19))));
    });

    test('Test fetch Apod of a specific date', () async {
      final PictureOfDay pictureOfDay =
          await nasaApodRepository.fetchPictureOfDay(date: '2016-02-06');

      expect(pictureOfDay.url, isNotNull);
    });

    test('Test thumbnail url is not null for Apod videos', () async {
      final PictureOfDay pictureOfDay =
          await nasaApodRepository.fetchPictureOfDay(date: '2016-02-09');

      expect(pictureOfDay.thumbnailUrl, isNotNull);
    });
  });
}
