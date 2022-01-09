import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');

  String format() => formatter.format(this);

  DateTime xDaysBefore([
    int days = 19,
  ]) =>
      this.subtract(Duration(days: days));
}
