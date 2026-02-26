import 'package:built_collection/built_collection.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hello_universe/src/data/apod_service.dart';
import 'package:hello_universe/src/data/apods_repository_impl.dart';
import 'package:hello_universe/src/data/models/apod_dto.dart';
import 'package:hello_universe/src/domain/entities/apods_error.dart';
import 'package:hello_universe/src/domain/apods_repository.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../test_doubles/test_models.dart';
import 'apods_repository_impl_test.mocks.dart';

late _ArrangeBuilder _builder;

@GenerateNiceMocks([MockSpec<ApodService>()])
void main() {
  const startDate = '2020-02-25';
  const endDate = '2020-02-05';
  setUp(() => _builder = _ArrangeBuilder());

  test('can be created', () {
    final tested = _builder.createTested();

    expect(tested, isA<ApodsRepositoryImpl>());
  });

  group('fetchApods', () {
    test('returns $TaskEither', () {
      final tested = _builder.createTested();

      final result = tested.fetchApods(
        startDate: startDate,
        endDate: endDate,
        includeThumbnails: true,
      );

      expect(result, isA<TaskEither>());
    });

    group('on run on $TaskEither', () {
      test('calls fetchImageList on $ApodService', () async {
        const startDate = '2000-10-22';
        const endDate = '2000-10-02';
        final tested = _builder.createTested();

        await tested
            .fetchApods(
              startDate: startDate,
              endDate: endDate,
              includeThumbnails: true,
            )
            .run();

        verify(
          _builder.apodService.fetchImageList(
            startDate: startDate,
            endDate: endDate,
            includeThumbnails: true,
          ),
        ).called(1);
      });

      test('returns ${List<Apod>} on success', () async {
        const title = 'Mars!';
        final apods = BuiltList<ApodDto>.from([
          TestModels.apodDto(title: title),
        ]);
        _builder.withApodServiceFetchImageListSuccess(result: apods);
        final tested = _builder.createTested();

        final taskResult = await tested
            .fetchApods(
              startDate: startDate,
              endDate: endDate,
              includeThumbnails: true,
            )
            .run();

        expect((taskResult as Right).value, [TestModels.apod(title: title)]);
      });

      test('returns $ApodsError on failure', () async {
        final error = Exception('Aliens attack!');
        _builder.withApodServiceFetchImageListFailure(error: error);
        final tested = _builder.createTested();

        final taskResult = await tested
            .fetchApods(
              startDate: startDate,
              endDate: endDate,
              includeThumbnails: true,
            )
            .run();

        expect(
          (taskResult as Left).value,
          isA<ApodsError>().having((p) => p.error, 'error', error),
        );
      });
    });
  });
}

class _ArrangeBuilder {
  final apodService = MockApodService();

  void withApodServiceFetchImageListSuccess({BuiltList<ApodDto>? result}) {
    when(
      _builder.apodService.fetchImageList(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
        includeThumbnails: anyNamed('includeThumbnails'),
      ),
    ).thenAnswer(
      (_) async =>
          Future.value(result ?? BuiltList.from([TestModels.apodDto()])),
    );
  }

  void withApodServiceFetchImageListFailure({Object? error}) {
    when(
      _builder.apodService.fetchImageList(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
        includeThumbnails: anyNamed('includeThumbnails'),
      ),
    ).thenThrow(error ?? Exception('error'));
  }

  ApodsRepository createTested({ApodService? apodService}) =>
      ApodsRepositoryImpl(apodService: apodService ?? this.apodService);
}
