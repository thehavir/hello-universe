import 'package:freezed_annotation/freezed_annotation.dart';

part 'apods_error.freezed.dart';

@freezed
abstract class ApodsError with _$ApodsError {
  const factory ApodsError(Object error, StackTrace stackTrace) = _ApodsError;
}
