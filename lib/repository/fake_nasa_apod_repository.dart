import 'package:hello_universe/api/models/apod.dart';
import 'package:hello_universe/repository/nasa_apod_repository.dart';

final PictureOfDay mockApod = PictureOfDay(
  copyright: 'mock1 copyright',
  date: 'mock1 date',
  explanation: 'mock1 explanation',
  hdurl: 'mock1 hdurl',
  mediaType: 'mock1 mediaType',
  serviceVersion: 'mock1 serviceVersion',
  title: 'mock1 title',
  url: 'mock1 url',
);

const String mockNasaApodApiErrorMessage =
    'An error occurred while fetching Nasa Apod';

class FakeNasaApodRepository implements NasaApodRepository {

  const FakeNasaApodRepository();

  @override
  Future<PictureOfDay> fetchPictureOfDay() async {
    await Future.delayed(Duration(seconds: 2));

    return mockApod;
  }
}
