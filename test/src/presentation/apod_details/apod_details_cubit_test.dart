// ignore_for_file: cascade_invocations, avoid_redundant_argument_values

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:file/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/domain/entities/media_type.dart';
import 'package:hello_universe/src/presentation/apod_details/apod_details_cubit.dart';
import 'package:hello_universe/src/utils/cubit_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../test_doubles/test_models.dart';
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

  group('when $MediaType is ${MediaType.video}', () {
    group('when thumbnailUrl is null', () {
      test('doest not get image from $CacheManager', () {
        _builder.createTested(
          apod: TestModels.apod(mediaType: .video, thumbnailUrl: null),
        );

        verifyZeroInteractions(_builder.cacheManager);
      });

      test('emits $LoadedCubitState', () {
        final tested = _builder.createTested(
          apod: TestModels.apod(mediaType: .video, thumbnailUrl: null),
        );

        expect(tested.state, isA<LoadedCubitState>());
      });
    });

    group('when thumbnailUrl is empty', () {
      test('doest not get image from $CacheManager', () {
        _builder.createTested(
          apod: TestModels.apod(mediaType: .video, thumbnailUrl: ''),
        );

        verifyZeroInteractions(_builder.cacheManager);
      });

      test('emits $LoadedCubitState', () {
        final tested = _builder.createTested(
          apod: TestModels.apod(mediaType: .video, thumbnailUrl: ''),
        );

        expect(tested.state, isA<LoadedCubitState>());
      });
    });

    group('when thumbnailUrl is not empty', () {
      test('calls getFileStream on $CacheManager with thumbnailUrl '
          'when it is not null', () async {
        const thumbnailUrl = 'http://a-galaxy-far-far-away.universe';
        final apod = TestModels.apod(
          mediaType: .video,
          thumbnailUrl: thumbnailUrl,
        );
        _builder.withCacheManagerGetFileStreamEmitsData(url: thumbnailUrl);

        _builder.createTested(apod: apod);

        verify(_builder.cacheManager.getFileStream(thumbnailUrl)).called(1);
      });

      blocTest(
        'emits loaded state when $CacheManager stream emits $FileInfo',
        setUp: () => _builder.withCacheManagerGetFileStreamEmitsData(
          streamData: _TestFileInfo(),
        ),
        build: () => _builder.createTested(
          apod: TestModels.apod(
            mediaType: .video,
            thumbnailUrl: 'thumbnailUrl',
          ),
        ),
        expect: () => [isA<LoadedCubitState>()],
      );
    });
  });

  <MediaType>[.image, .other].forEach((mediaType) {
    group('when $MediaType is $mediaType', () {
      test('calls getFileStream on $CacheManager with thumbnailUrl '
          'when it is not null', () async {
        const thumbnailUrl = 'http://a-galaxy-far-far-away.universe';
        final apod = TestModels.apod(
          mediaType: mediaType,
          thumbnailUrl: thumbnailUrl,
        );
        _builder.withCacheManagerGetFileStreamEmitsData(url: thumbnailUrl);

        _builder.createTested(apod: apod);

        verify(_builder.cacheManager.getFileStream(thumbnailUrl)).called(1);
      });

      test('calls getFileStream on $CacheManager with url '
          'when thumbnailUrl is null', () async {
        const url = 'http://a-galaxy-far-far-away.universe';
        final apod = TestModels.apod(thumbnailUrl: null, url: url);
        _builder.withCacheManagerGetFileStreamEmitsData(url: url);

        _builder.createTested(apod: apod);

        verify(_builder.cacheManager.getFileStream(url)).called(1);
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
    });
  });
}

class _ArrangeBuilder {
  final cacheManager = MockCacheManager();

  void withCacheManagerGetFileStreamEmitsData({
    String? url,
    FileResponse? streamData,
  }) {
    when(
      cacheManager.getFileStream(url ?? any),
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

  ApodDetailsCubit createTested({Apod? apod}) => ApodDetailsCubit(
    cacheManager: cacheManager,
    apod: apod ?? TestModels.apod(),
  );
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
