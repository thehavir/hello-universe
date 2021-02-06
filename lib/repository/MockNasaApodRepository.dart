import 'package:hello_universe/model/picture_of_day.dart';
import 'package:hello_universe/repository/NasaApodRepository.dart';

final mockApod = PictureOfDay(
  copyright: 'mock1 copyright',
  date: 'mock1 date',
  explanation: 'mock1 explanation',
  hdurl: 'mock1 hdurl',
  mediaType: 'mock1 mediaType',
  serviceVersion: 'mock1 serviceVersion',
  title: 'mock1 title',
  url: 'mock1 url',
);

class MockNasaApodRepository implements NasaApodRepository {
  @override
  Future<PictureOfDay> fetchPictureOfDay() async {
    await Future.delayed(Duration(seconds: 2));

    return mockApod;
  }
}
