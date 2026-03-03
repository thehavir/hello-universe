import 'package:freezed_annotation/freezed_annotation.dart';

part 'apod_full_size_screen_arguments.freezed.dart';

@freezed
abstract class ApodFullSizeScreenArguments with _$ApodFullSizeScreenArguments {
  const factory ApodFullSizeScreenArguments({
    required String url,
    required DateTime date,
  }) = _ApodFullSizeScreenArguments;
}
