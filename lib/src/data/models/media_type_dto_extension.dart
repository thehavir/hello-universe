import 'package:hello_universe/src/data/models/media_type_dto.dart';
import 'package:hello_universe/src/domain/entities/media_type.dart';

extension MediaTypeDtoExtension on MediaTypeDto {
  MediaType toEntity() => MediaType.values.byName(name);
}
