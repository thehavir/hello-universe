import 'package:hello_universe/api/models/apod.dart';
import 'package:hello_universe/repository/nasa_apod_repository.dart';

/// Mock data for the response of fetching picture of day api
/// (https://api.nasa.gov/planetary/apod).
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

/// Mock error message for fetching picture of day.
const String mockNasaApodApiErrorMessage =
    'An error occurred while fetching Nasa Apod';

/// Fake implementation of [NasaApodRepository] in order to test business logic.
class FakeNasaApodRepository implements NasaApodRepository {
  const FakeNasaApodRepository();

  /// After 2 seconds will return [mockApod] as the picture of day.
  @override
  Future<PictureOfDay> fetchPictureOfDay() async {
    await Future.delayed(Duration(seconds: 2));

    return mockApod;
  }
}
