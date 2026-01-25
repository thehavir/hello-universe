import 'package:hello_universe/src/data/media_type.dart';
import 'package:test/test.dart';

void main() {
  test('has all values', () {
    expect(MediaType.values.length, 3);
  });

  <MediaType, String>{
    MediaType.image: 'image',
    MediaType.video: 'video',
    MediaType.other: 'other',
  }.forEach((type, value) {
    test('media type $type has $value value', () {
      final tested = MediaType.valueOf(value);
      expect(tested, type);
    });
  });
}
