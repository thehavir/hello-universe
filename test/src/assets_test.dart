import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/assets.dart';

void main() {
  test('${Assets.errorIcon} has assets/error.png value', () {
    expect(Assets.errorIcon, 'assets/error.png');
  });

  test('${Assets.noResultIcon} has assets/no-results.png value', () {
    expect(Assets.noResultIcon, 'assets/no-results.png');
  });

  test('${Assets.noImageIcon} has assets/no-image.png value', () {
    expect(Assets.noImageIcon, 'assets/no-image.png');
  });

  test('${Assets.placeholder} has assets/placeholder.png value', () {
    expect(Assets.placeholder, 'assets/placeholder.png');
  });
}
