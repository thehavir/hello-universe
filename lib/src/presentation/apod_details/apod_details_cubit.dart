import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/utils/cubit_state.dart';

typedef ApodDetailsState = CubitState<void, Object>;

class ApodDetailsCubit extends Cubit<ApodDetailsState> {
  ApodDetailsCubit({required CacheManager cacheManager, required Apod apod})
    : _cacheManager = cacheManager,
      _apod = apod,
      super(const LoadingCubitState()) {
    _init();
  }

  final CacheManager _cacheManager;
  final Apod _apod;

  StreamSubscription<FileResponse>? _apodFileStream;

  Future<void> _init() async {
    try {
      final isVideo = _apod.mediaType == .video;
      final thumbnailUrl = _apod.thumbnailUrl;
      if (isVideo && (thumbnailUrl == null || thumbnailUrl.isEmpty)) {
        emit(state.toLoaded(null));
        return;
      }

      final stream = _cacheManager.getFileStream(thumbnailUrl ?? _apod.url);
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
  Future<void> close() async {
    await _cancelStream();
    return super.close();
  }
}
