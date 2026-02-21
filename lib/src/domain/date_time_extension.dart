import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  static final formatter = DateFormat('yyyy-MM-dd');

  String format() => formatter.format(this);
}
