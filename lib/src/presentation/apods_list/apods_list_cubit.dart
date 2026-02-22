import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_universe/src/domain/apods_error.dart';
import 'package:hello_universe/src/domain/fetch_apods_use_case.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_data.dart';
import 'package:hello_universe/src/utils/persistent_cubit_state.dart';

typedef ApodsListState = PersistentCubitState<ApodsListData, ApodsError>;

class ApodsListCubit extends Cubit<ApodsListState> {
  ApodsListCubit({required FetchApodsUseCase fetchApodsUseCase})
    : _fetchApodsUseCase = fetchApodsUseCase,
      super(const PersistentLoadingCubitState());

  final FetchApodsUseCase _fetchApodsUseCase;

  Future<void> fetchApods() async {
    final data = state.data;
    final apodPageKeys = data?.apodPageKeys;
    final lastPageKey = apodPageKeys?.last;
    final result = await _fetchApodsUseCase
        .execute(currentPageKey: lastPageKey)
        .run();

    final newState = result.match((error) => state.toError(error), (apodPage) {
      final allApods = [...?data?.apodPages, apodPage.apods.reversed.toList()];
      final allApodPageKeys = [...?apodPageKeys, apodPage.pageKey];
      return state.toLoaded(
        ApodsListData(
          apodPages: allApods,
          apodPageKeys: allApodPageKeys,
          hasNextPage: !apodPage.pageKey.isLastPage,
        ),
      );
    });

    emit(newState);
  }

  Future<void> refresh() {
    emit(state.toLoading());
    return fetchApods();
  }
}
