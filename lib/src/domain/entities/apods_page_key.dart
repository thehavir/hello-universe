import 'package:freezed_annotation/freezed_annotation.dart';

part 'apods_page_key.freezed.dart';

abstract class PageKey<T> {}

@freezed
abstract class ApodsPageKey with _$ApodsPageKey implements PageKey<DateTime> {
  const factory ApodsPageKey({
    required DateTime startDate,
    required DateTime endDate,
    required bool isLastPage,
  }) = _ApodsPageKey;
}
