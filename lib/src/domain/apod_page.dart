import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_universe/src/domain/apods_page_key.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';

part 'apod_page.freezed.dart';

@freezed
abstract class ApodPage with _$ApodPage {
  const factory ApodPage({
    required List<Apod> apods,
    required ApodsPageKey pageKey,
  }) = _ApodPage;
}
