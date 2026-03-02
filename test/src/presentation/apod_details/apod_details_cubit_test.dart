// ignore_for_file: cascade_invocations

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:file/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hello_universe/src/presentation/apod_details/apod_details_cubit.dart';
import 'package:hello_universe/src/utils/cubit_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'apod_details_cubit_test.mocks.dart';

late _ArrangeBuilder _builder;

@GenerateNiceMocks([MockSpec<CacheManager>()])
void main() {
  setUp(() => _builder = _ArrangeBuilder());

  test('can be created', () {
    final tested = _builder.createTested();

    expect(tested, isA<ApodDetailsCubit>());
  });

  test('has $LoadingCubitState as initial state', () {
    final tested = _builder.createTested();

    expect(tested.state, isA<LoadingCubitState>());
  });

  test('calls getFileStream on $CacheManager with apodUrl', () async {
    const apodUrl = 'http://a-galaxy-far-far-away.universe';
    _builder.withCacheManagerGetFileStreamEmitsData(apodUrl: apodUrl);

    _builder.createTested(apodUrl: apodUrl);

    verify(_builder.cacheManager.getFileStream(apodUrl)).called(1);
  });

  group('when $CacheManager stream emits $FileInfo', () {
    blocTest(
      'emits loaded state',
      setUp: () => _builder.withCacheManagerGetFileStreamEmitsData(
        streamData: _TestFileInfo(),
      ),
      build: () => _builder.createTested(),
      expect: () => [isA<LoadedCubitState>()],
    );

    blocTest<ApodDetailsCubit, ApodDetailsState>(
      'does not emit again after last emit',
      setUp: () {
        final controller = StreamController<FileResponse>();
        controller.add(_TestFileInfo());
        controller.addError('error');
        when(
          _builder.cacheManager.getFileStream(any),
        ).thenAnswer((_) => controller.stream);
      },
      build: () => _builder.createTested(),
      expect: () => [isA<LoadedCubitState>()],
    );
  });

  blocTest(
    'does not emit loaded state '
    'when $CacheManager stream does not emit $FileInfo',
    setUp: () => _builder.withCacheManagerGetFileStreamEmitsData(
      streamData: _TestFileResponse(),
    ),
    build: () => _builder.createTested(),
    expect: () => isEmpty,
  );

  group('when stream emits error', () {
    blocTest<ApodDetailsCubit, ApodDetailsState>(
      'emits error state',
      setUp: () => _builder.withCacheManagerGetFileStreamEmitsError(),
      build: () => _builder.createTested(),
      expect: () => [isA<ErrorCubitState>()],
    );

    blocTest<ApodDetailsCubit, ApodDetailsState>(
      'does not emit again after last emit',
      setUp: () {
        final controller = StreamController<FileResponse>();
        controller.addError('error');
        controller.add(_TestFileInfo());
        when(
          _builder.cacheManager.getFileStream(any),
        ).thenAnswer((_) => controller.stream);
      },
      build: () => _builder.createTested(),
      expect: () => [isA<ErrorCubitState>()],
    );
  });

  test('emits error state when stream throws', () async {
    const error = 'Moon is bleeding!';
    _builder.withCacheManagerGetFileStreamThrows(error: error);

    final tested = _builder.createTested();
    await Future<void>.delayed(.zero);

    expect(
      tested.state,
      isA<ErrorCubitState>().having((p) => p.error, 'error', error),
    );
  });

  test('does not emit when cubit is closed', () async {
    _builder.withCacheManagerGetFileStreamEmitsData(
      streamData: _TestFileInfo(),
    );
    final tested = _builder.createTested();

    await tested.close();

    expect(tested.state, isA<LoadingCubitState>());
  });
}

class _ArrangeBuilder {
  final cacheManager = MockCacheManager();

  void withCacheManagerGetFileStreamEmitsData({
    String? apodUrl,
    FileResponse? streamData,
  }) {
    when(
      cacheManager.getFileStream(apodUrl ?? any),
    ).thenAnswer((_) => Stream.value(streamData ?? _TestFileResponse()));
  }

  void withCacheManagerGetFileStreamThrows({Object? error}) {
    when(cacheManager.getFileStream(any)).thenThrow(error ?? 'error');
  }

  void withCacheManagerGetFileStreamEmitsError({Object? error}) {
    when(
      cacheManager.getFileStream(any),
    ).thenAnswer((_) => Stream.error(error ?? 'error'));
  }

  ApodDetailsCubit createTested({String? apodUrl}) =>
      ApodDetailsCubit(cacheManager: cacheManager, apodUrl: apodUrl ?? '');
}

class _TestFileResponse implements FileResponse {
  @override
  String get originalUrl => throw UnimplementedError();
}

class _TestFileInfo implements FileInfo {
  @override
  File get file => throw UnimplementedError();

  @override
  String get originalUrl => throw UnimplementedError();

  @override
  FileSource get source => throw UnimplementedError();

  @override
  int get statusCode => throw UnimplementedError();

  @override
  DateTime get validTill => throw UnimplementedError();
}
