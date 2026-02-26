import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_universe/src/domain/entities/apods_page_key.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';

part 'apods_list_data.freezed.dart';

@freezed
abstract class ApodsListData with _$ApodsListData {
  const factory ApodsListData({
    required List<List<Apod>> apodPages,
    required List<ApodsPageKey> apodPageKeys,
    required bool hasNextPage,
  }) = _ApodsListData;
}
