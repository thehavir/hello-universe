import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_universe/src/domain/entities/media_type.dart';

part 'apod.freezed.dart';

@freezed
abstract class Apod with _$Apod {
  const factory Apod({
    required DateTime? date,
    required String? title,
    required String? explanation,
    required String? copyright,
    required MediaType? mediaType,
    required String? url,
    required String? hdUrl,
    required String? thumbnailUrl,
    required String? serviceVersion,
  }) = _Apod;
}
