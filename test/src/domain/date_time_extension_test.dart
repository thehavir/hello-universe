import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/domain/date_time_extension.dart';

void main() {
  test('formats', () {
    final date = DateTime(2020, 6, 3, 1, 45, 31, 122);

    expect(date.format(), '2020-06-03');
  });
}
