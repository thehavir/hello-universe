import 'package:hello_universe/model/picture_of_day.dart';

abstract class NasaApodRepository {
  Future<PictureOfDay> fetchPictureOfDay();
}