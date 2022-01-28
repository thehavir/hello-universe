import 'package:hello_universe/models/models.dart';

/// Extensions on `Apod`.
extension ApodExtension on Apod {
  /// Determine if it is video by checking `thumbnailUrl`.
  bool get isVideo => thumbnailUrl != null;

  /// Returns url of image.
  /// If it's video, then it returns `thumbnailUrl`.
  String? get imageUrl => isVideo ? thumbnailUrl : url;
}
