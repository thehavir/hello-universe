import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/features/image_list/extensions/extensions.dart';
import 'package:intl/intl.dart';

void main() {
  group('Test `DateExtension`', () {
    final DateTime now = DateTime.now();

    test('Test format method', () {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');

      expect(now.format(), formatter.format(now));
    });

    test('Test xDaysBefore method', () {
      expect(now.xDaysBefore(1), now.subtract(Duration(days: 1)));
      expect(now.xDaysBefore(19), now.subtract(Duration(days: 19)));
    });
  });
}