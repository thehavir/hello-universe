import 'package:hello_universe/src/utils/navigation/nullable_object_extension.dart';
import 'package:test/test.dart';

void main() {
  test('throws on null', () {
    expect(() => null.forceCast<_MockObject>(), throwsArgumentError);
  });

  test('throws on other', () {
    expect(() => Object().forceCast<_MockObject>(), throwsArgumentError);
  });

  test('casts properly', () {
    expect(_MockObject().forceCast<_MockObject>(), isA<_MockObject>());
  });
}

class _MockObject {}
