import 'package:hello_universe/src/data/models/media_type_dto.dart';
import 'package:test/test.dart';

void main() {
  test('has all values', () {
    expect(MediaTypeDto.values.length, 3);
  });

  <MediaTypeDto, String>{
    MediaTypeDto.image: 'image',
    MediaTypeDto.video: 'video',
    MediaTypeDto.other: 'other',
  }.forEach((type, value) {
    test('media type $type has $value value', () {
      final tested = MediaTypeDto.valueOf(value);
      expect(tested, type);
    });
  });
}
