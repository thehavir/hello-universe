import 'package:hello_universe/models/models.dart';

/// Contract for the Nasa Apod repository.
///
/// With this interface we are able to implement fake/mock repository in order
/// to test the business logic.
abstract class BaseRepository {
  /// Abstract method for fetching the picture of day from Nasa APOD repository.
  Future<Apod> fetchApod({
    String date,
  });

  /// Abstract method for fetching list of images (APOD). The list is contains
  /// images from [startDate] to [endDate].
  Future<List<Apod>> fetchImageList({
    required String startDate,
    required String endDate,
  });
}
