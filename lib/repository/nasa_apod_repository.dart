import 'package:hello_universe/api/models/apod.dart';

abstract class NasaApodRepository {
  Future<PictureOfDay> fetchPictureOfDay();
}
