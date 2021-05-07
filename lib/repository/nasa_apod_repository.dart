import 'package:flutter/foundation.dart';
import 'package:hello_universe/api/models/apod.dart';

/// Contract for the Nasa Apod repository.
///
/// With this interface we are able to implement fake/mock repository in order
/// to test the business logic.
abstract class NasaApodRepository {
  /// Abstract method for fetching the picture of day from Nasa APOD repository.
  Future<PictureOfDay> fetchPictureOfDay();

  /// Abstract method for fetching list of images (APOD). The list is contains
  /// images from [startDate] to [endDate].
  Future<List<PictureOfDay>> fetchImageList({
    @required String startDate,
    @required String endDate,
  });
}
