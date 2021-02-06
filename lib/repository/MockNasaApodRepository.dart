import 'package:hello_universe/model/picture_of_day.dart';
import 'package:hello_universe/repository/NasaApodRepository.dart';

class MockNasaApodRepository implements NasaApodRepository {
  @override
  Future<PictureOfDay> fetchPictureOfDay() {
    // TODO: implement fetchPictureOfDay
    throw UnimplementedError();
  }
}