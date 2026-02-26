import 'package:hello_universe/src/utils/navigation/nullable_object_extension.dart';
import 'package:test/test.dart';

void main() {
  test('throws on null', () {
    expect(() => null.forceCast<_TestObject>(), throwsArgumentError);
  });

  test('throws on other', () {
    expect(() => Object().forceCast<_TestObject>(), throwsArgumentError);
  });

  test('casts properly', () {
    expect(_TestObject().forceCast<_TestObject>(), isA<_TestObject>());
  });
}

class _TestObject {}
