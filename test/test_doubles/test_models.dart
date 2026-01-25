import 'package:hello_universe/src/data/apod.dart';
import 'package:hello_universe/src/data/media_type.dart';

abstract final class TestModels {
  static Apod apod({
    String? copyright,
    String? date,
    String? explanation,
    String? hdUrl,
    MediaType? mediaType,
    String? serviceVersion,
    String? title,
    String? url,
    String? thumbnailUrl,
  }) => Apod(
    (b) => b
      ..copyright = copyright
      ..date = date
      ..explanation = explanation
      ..hdUrl = hdUrl
      ..mediaType = mediaType
      ..serviceVersion = serviceVersion
      ..title = title
      ..url = url
      ..thumbnailUrl = thumbnailUrl,
  );
}
