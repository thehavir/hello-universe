import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_universe/src/domain/apods_page_key.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';

part 'apods_data.freezed.dart';

@freezed
abstract class ApodsData with _$ApodsData {
  const factory ApodsData({
    required List<List<Apod>> apodPages,
    required List<ApodsPageKey> apodPageKeys,
    required bool hasNextPage,
  }) = _ApodsData;
}
