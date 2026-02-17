import 'package:hello_universe/src/data/models/apod_dto.dart';
import 'package:hello_universe/src/data/models/media_type_dto_extension.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';

extension ApodDtoExtension on ApodDto {
  Apod toEntity() {
    final date = this.date;
    return Apod(
      date: date == null ? null : DateTime.tryParse(date),
      title: title,
      explanation: explanation,
      copyright: copyright,
      mediaType: mediaType?.toEntity(),
      url: url,
      hdUrl: hdUrl,
      thumbnailUrl: thumbnailUrl,
      serviceVersion: serviceVersion,
    );
  }
}
