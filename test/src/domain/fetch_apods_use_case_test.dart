// ignore_for_file: cascade_invocations, avoid_redundant_argument_values

import 'package:fpdart/fpdart.dart';
import 'package:hello_universe/src/domain/entities/apod_page.dart';
import 'package:hello_universe/src/domain/entities/apods_error.dart';
import 'package:hello_universe/src/domain/entities/apods_page_key.dart';
import 'package:hello_universe/src/domain/apods_pagination_handler.dart';
import 'package:hello_universe/src/domain/apods_repository.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/domain/fetch_apods_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../test_doubles/test_models.dart';
import 'fetch_apods_use_case_test.mocks.dart';

late _ArrangeBuilder _builder;

@GenerateNiceMocks([
  MockSpec<ApodsPaginationHandler>(),
  MockSpec<ApodsRepository>(),
])
void main() {
  final pageKey = TestModels.apodsPageKey();
  final response = TaskEither<ApodsError, List<Apod>>.fromEither(
    Right([TestModels.apod()]),
  );
  provideDummy(pageKey);
  provideDummy(response);

  setUp(() => _builder = _ArrangeBuilder());

  test('can be created', () async {
    final tested = _builder.createTested();

    expect(tested, isA<FetchApodsUseCaseImpl>());
  });

  group('on execute', () {
    test('calls nextPageKey on the $ApodsPaginationHandler '
        'with current page key as null when it is null', () async {
      _builder.withApodsPaginationHandler();
      final tested = _builder.createTested();

      tested.execute(currentPageKey: null);

      verify(_builder.apodsPaginationHandler.nextPageKey(null)).called(1);
    });

    test('calls nextPageKey on the $ApodsPaginationHandler '
        'with current page when it is not null', () async {
      final currentPageKey = TestModels.apodsPageKey(endDate: DateTime(1999));
      _builder.withApodsPaginationHandler(currentPageKey: currentPageKey);
      final tested = _builder.createTested();

      tested.execute(currentPageKey: currentPageKey);

      verify(
        _builder.apodsPaginationHandler.nextPageKey(currentPageKey),
      ).called(1);
    });

    test(
      'calls fetchApods on the $ApodsRepository '
      'with the next $ApodsPageKey got from $ApodsPaginationHandler',
      () async {
        final nextPageKey = TestModels.apodsPageKey(
          startDate: DateTime(2021, 01, 10),
          endDate: DateTime(2021, 01, 20),
        );
        final currentPageKey = TestModels.apodsPageKey(endDate: DateTime(2000));
        _builder.withApodsPaginationHandler(
          currentPageKey: currentPageKey,
          result: nextPageKey,
        );
        final tested = _builder.createTested();

        tested.execute(currentPageKey: currentPageKey);

        verify(
          _builder.apodsRepository.fetchApods(
            startDate: '2021-01-10',
            endDate: '2021-01-20',
            includeThumbnails: true,
          ),
        ).called(1);
      },
    );

    test('maps ${List<Apod>} result from $ApodsRepository to the $ApodPage '
        'when it is success', () async {
      final currentPageKey = TestModels.apodsPageKey(endDate: DateTime(2001));
      final nextPageKey = TestModels.apodsPageKey(
        startDate: DateTime(2024, 05, 05),
        endDate: DateTime(2024, 05, 15),
        isLastPage: true,
      );
      final apods = [
        TestModels.apod(title: 'a1'),
        TestModels.apod(title: 'b2'),
      ];
      _builder
        ..withApodsPaginationHandler(
          currentPageKey: currentPageKey,
          result: nextPageKey,
        )
        ..withApodsRepositoryFetchApodsSuccess(result: apods);
      final tested = _builder.createTested();

      final result = await tested.execute(currentPageKey: currentPageKey).run();

      expect(
        (result as Right).value,
        ApodPage(apods: apods, pageKey: nextPageKey),
      );
    });

    test('returns $ApodsError from $ApodsRepository when it fails', () async {
      final error = ApodsError(Exception('Moon vanished!'), StackTrace.current);
      _builder
        ..withApodsRepositoryFetchApodsFailure(error: error)
        ..withApodsPaginationHandler();
      final tested = _builder.createTested();

      final result = await tested.execute(currentPageKey: null).run();

      expect((result as Left).value, error);
    });
  });
}

class _ArrangeBuilder {
  final apodsRepository = MockApodsRepository();
  final apodsPaginationHandler = MockApodsPaginationHandler();

  void withApodsPaginationHandler({
    ApodsPageKey? currentPageKey,
    ApodsPageKey? result,
  }) {
    when(
      _builder.apodsPaginationHandler.nextPageKey(currentPageKey),
    ).thenReturn(result ?? TestModels.apodsPageKey());
  }

  void withApodsRepositoryFetchApodsSuccess({List<Apod>? result}) {
    when(
      _builder.apodsRepository.fetchApods(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
        includeThumbnails: anyNamed('includeThumbnails'),
      ),
    ).thenAnswer(
      (_) => TaskEither<ApodsError, List<Apod>>.fromEither(
        Right(result ?? [TestModels.apod()]),
      ),
    );
  }

  void withApodsRepositoryFetchApodsFailure({ApodsError? error}) {
    when(
      _builder.apodsRepository.fetchApods(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
        includeThumbnails: anyNamed('includeThumbnails'),
      ),
    ).thenAnswer(
      (_) => TaskEither<ApodsError, List<Apod>>.fromEither(
        Left(error ?? TestModels.apodsError()),
      ),
    );
  }

  FetchApodsUseCase createTested() => FetchApodsUseCaseImpl(
    apodsRepository: apodsRepository,
    apodsPaginationHandler: apodsPaginationHandler,
  );
}
