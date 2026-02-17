import 'package:hello_universe/src/data/models/media_type_dto.dart';
import 'package:hello_universe/src/data/models/media_type_dto_extension.dart';
import 'package:hello_universe/src/domain/entities/media_type.dart';
import 'package:test/test.dart';

void main() {
  <MediaTypeDto, MediaType>{
    .image: .image,
    .video: .video,
    .other: .other,
  }.forEach((dto, entity) {
    test('toEntity maps $dto to $entity', () {
      expect(dto.toEntity(), entity);
    });
  });
}
