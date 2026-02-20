import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_universe/src/domain/fetch_apods_use_case.dart';
import 'package:hello_universe/src/presentation/apods_data.dart';
import 'package:hello_universe/src/utils/persistent_cubit_state.dart';

typedef ApodsState = PersistentCubitState<ApodsData, Object>;

class ApodsCubit extends Cubit<ApodsState> {
  ApodsCubit({required FetchApodsUseCase fetchApodsUseCase})
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
        ApodsData(
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
