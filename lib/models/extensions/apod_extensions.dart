import 'package:hello_universe/models/apod.dart';

/// Extensions on `PictureOfDay`.
extension ApodExtension on PictureOfDay {
  /// Determine if it is video by checking `thumbnailUrl`.
  bool get isVideo => thumbnailUrl != null;

  /// Returns url of image.
  /// If it's video, then it returns `thumbnailUrl`.
  String? get imageUrl => isVideo ? thumbnailUrl : url;
}
