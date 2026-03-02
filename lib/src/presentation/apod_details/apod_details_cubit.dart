import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hello_universe/src/utils/cubit_state.dart';

typedef ApodDetailsState = CubitState<void, Object>;

class ApodDetailsCubit extends Cubit<ApodDetailsState> {
  ApodDetailsCubit({
    required CacheManager cacheManager,
    required String apodUrl,
  }) : _cacheManager = cacheManager,
       _apodUrl = apodUrl,
       super(const LoadingCubitState()) {
    _init();
  }

  final CacheManager _cacheManager;
  final String _apodUrl;

  StreamSubscription<FileResponse>? _apodFileStream;

  Future<void> _init() async {
    try {
      final stream = _cacheManager.getFileStream(_apodUrl);
      _apodFileStream = stream.listen(
        _onApodStreamData,
        onError: _onApodStreamError,
      );
    } catch (error) {
      emit(state.toError(error));
    }
  }

  Future<void> _onApodStreamData(FileResponse fileResponse) async {
    if (fileResponse is FileInfo) {
      emit(state.toLoaded(null));
      await _cancelStream();
    }
  }

  void _onApodStreamError(Object? error) {
    emit(state.toError(error ?? 'Stream failed'));
    _cancelStream();
  }

  Future<void> _cancelStream() async {
    await _apodFileStream?.cancel();
    _apodFileStream = null;
  }

  @override
  Future<void> close() {
    _cancelStream();
    return super.close();
  }
}
