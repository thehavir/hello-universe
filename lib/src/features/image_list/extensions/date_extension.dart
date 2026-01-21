import 'package:intl/intl.dart';

/// Extensions on [DateTime].
extension DateExtension on DateTime {
  /// The app [DateFormat].
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');

  /// Formats [DateTime] with `formatter`.
  String format() => formatter.format(this);

  /// Subtracts this [DateTime] by `days`.
  /// By default it subtracts 20 days.
  DateTime xDaysBefore([
    int days = 20,
  ]) =>
      subtract(Duration(days: days));
}
