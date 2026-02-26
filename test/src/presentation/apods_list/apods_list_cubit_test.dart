// ignore_for_file: avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hello_universe/src/domain/entities/apod_page.dart';
import 'package:hello_universe/src/domain/entities/apods_error.dart';
import 'package:hello_universe/src/domain/entities/apods_page_key.dart';
import 'package:hello_universe/src/domain/fetch_apods_use_case.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_cubit.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_data.dart';
import 'package:hello_universe/src/utils/persistent_cubit_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../test_doubles/test_models.dart';
import 'apods_list_cubit_test.mocks.dart';

late _ArrangeBuilder _builder;

@GenerateNiceMocks([MockSpec<FetchApodsUseCase>()])
void main() {
  provideDummy(
    TaskEither<ApodsError, ApodPage>.fromEither(Right(TestModels.apodPage())),
  );

  setUp(() => _builder = _ArrangeBuilder());

  test('can be created', () async {
    final tested = _builder.createTested();

    expect(tested, isA<ApodsListCubit>());
  });

  test('has $PersistentLoadingCubitState as initial state', () async {
    final tested = _builder.createTested();

    expect(tested.state, isA<PersistentLoadingCubitState>());
  });

  group('on fetchApods', () {
    test('calls execute on $FetchApodsUseCase and pass null to it '
        'when data on the cubit is null', () async {
      final tested = _builder.createTested();

      await tested.fetchApods();

      verify(
        _builder.fetchApodsUseCase.execute(currentPageKey: null),
      ).called(1);
    });

    blocTest(
      'calls execute on $FetchApodsUseCase and pass last $ApodsPageKey to it '
      'when data on the cubit is not null',
      build: () => _builder.createTested(),
      seed: () => PersistentLoadedCubitState<ApodsListData, ApodsError>(
        TestModels.apodsData(
          apodPageKeys: [
            TestModels.apodsPageKey(startDate: DateTime(1999)),
            TestModels.apodsPageKey(startDate: DateTime(2050)),
          ],
        ),
      ),
      act: (cubit) => cubit.fetchApods(),
      verify: (_) => verify(
        _builder.fetchApodsUseCase.execute(
          currentPageKey: TestModels.apodsPageKey(startDate: DateTime(2050)),
        ),
      ).called(1),
    );

    test('emits error with the error when $FetchApodsUseCase fails', () async {
      final error = ApodsError('Sun is exploding', StackTrace.current);
      _builder.withFetchApodsUseCaseFailure(error: error);
      final tested = _builder.createTested();

      await tested.fetchApods();

      expect(
        tested.state,
        isA<PersistentErrorCubitState>().having((p) => p.error, 'error', error),
      );
    });

    test(
      'emits loaded state with reveresed list of apods from $FetchApodsUseCase '
      'when it is success and current data in the cubit is null',
      () async {
        final apod1 = TestModels.apod(title: '1');
        final apod2 = TestModels.apod(title: '2');
        final result = TestModels.apodPage(apods: [apod1, apod2]);
        _builder.withFetchApodsUseCaseSuccess(result: result);
        final tested = _builder.createTested();

        await tested.fetchApods();

        expect(
          tested.state,
          isA<ApodsListState>().having((p) => p.data?.apodPages, 'apodPages', [
            [apod2, apod1],
          ]),
        );
      },
    );

    blocTest(
      'emits loaded state with reveresed list of apods from $FetchApodsUseCase '
      'and current apods from current cubit data '
      'when it is success and current data in the cubit is not null',
      setUp: () => _builder.withFetchApodsUseCaseSuccess(
        result: TestModels.apodPage(
          apods: [
            TestModels.apod(title: '1'),
            TestModels.apod(title: '2'),
          ],
        ),
      ),
      build: () => _builder.createTested(),
      seed: () => PersistentLoadedCubitState<ApodsListData, ApodsError>(
        TestModels.apodsData(
          apodPages: [
            // first page
            [TestModels.apod(title: 'old-1'), TestModels.apod(title: 'old-2')],
            // second page
            [TestModels.apod(title: 'old-3'), TestModels.apod(title: 'old-4')],
          ],
        ),
      ),
      act: (cubit) => cubit.fetchApods(),
      expect: () => [
        isA<ApodsListState>().having((p) => p.data?.apodPages, 'apodPages', [
          [TestModels.apod(title: 'old-1'), TestModels.apod(title: 'old-2')],
          [TestModels.apod(title: 'old-3'), TestModels.apod(title: 'old-4')],
          [TestModels.apod(title: '2'), TestModels.apod(title: '1')],
        ]),
      ],
    );

    test('emits loaded state with $ApodsPageKey from $FetchApodsUseCase '
        'when it is success and current data in the cubit is null', () async {
      final pageKey = TestModels.apodsPageKey(startDate: DateTime(2066));
      final result = TestModels.apodPage(pageKey: pageKey);
      _builder.withFetchApodsUseCaseSuccess(result: result);
      final tested = _builder.createTested();

      await tested.fetchApods();

      expect(
        tested.state,
        isA<ApodsListState>().having(
          (p) => p.data?.apodPageKeys,
          'apodPageKeys',
          [pageKey],
        ),
      );
    });

    blocTest(
      'emits loaded state with $ApodsPageKey from $FetchApodsUseCase '
      'and current ${ApodsPageKey}s from current cubit data '
      'when it is success and current data in the cubit is not null',
      setUp: () => _builder.withFetchApodsUseCaseSuccess(
        result: TestModels.apodPage(
          pageKey: TestModels.apodsPageKey(startDate: DateTime(2066)),
        ),
      ),
      build: () => _builder.createTested(),
      seed: () => PersistentLoadedCubitState<ApodsListData, ApodsError>(
        TestModels.apodsData(
          apodPageKeys: [
            // first page's pageKey
            TestModels.apodsPageKey(startDate: DateTime(1800)),
            // second page's pageKey
            TestModels.apodsPageKey(startDate: DateTime(1999)),
          ],
        ),
      ),
      act: (cubit) => cubit.fetchApods(),
      expect: () => [
        isA<ApodsListState>()
            .having((p) => p.data?.apodPageKeys, 'apodPageKeys', [
              TestModels.apodsPageKey(startDate: DateTime(1800)),
              TestModels.apodsPageKey(startDate: DateTime(1999)),
              TestModels.apodsPageKey(startDate: DateTime(2066)),
            ]),
      ],
    );

    test('emits loaded state with hasNextPage as false '
        'when $FetchApodsUseCase return isLastPage true', () async {
      _builder.withFetchApodsUseCaseSuccess(
        result: TestModels.apodPage(
          pageKey: TestModels.apodsPageKey(isLastPage: false),
        ),
      );
      final tested = _builder.createTested();

      await tested.fetchApods();

      expect(
        tested.state,
        isA<ApodsListState>().having(
          (p) => p.data?.hasNextPage,
          'hasNextPage',
          isTrue,
        ),
      );
    });

    test('emits loaded state with hasNextPage as true '
        'when $FetchApodsUseCase return isLastPage false', () async {
      _builder.withFetchApodsUseCaseSuccess(
        result: TestModels.apodPage(
          pageKey: TestModels.apodsPageKey(isLastPage: true),
        ),
      );
      final tested = _builder.createTested();

      await tested.fetchApods();

      expect(
        tested.state,
        isA<ApodsListState>().having(
          (p) => p.data?.hasNextPage,
          'hasNextPage',
          isFalse,
        ),
      );
    });
  });

  group('on refresh', () {
    blocTest(
      'emits loading state',
      setUp: () => _builder.withFetchApodsUseCaseSuccess(),
      build: () => _builder.createTested(),
      act: (cubit) => cubit.refresh(),
      expect: () => [isA<PersistentLoadingCubitState>(), isA<ApodsListState>()],
    );
  });

  test('calls fetchApods', () async {
    _builder.withFetchApodsUseCaseSuccess();
    final tested = _builder.createTested();

    await tested.fetchApods();

    verify(_builder.fetchApodsUseCase.execute(currentPageKey: null)).called(1);
  });
}

class _ArrangeBuilder {
  final fetchApodsUseCase = MockFetchApodsUseCase();

  void withFetchApodsUseCaseSuccess({ApodPage? result}) {
    when(
      _builder.fetchApodsUseCase.execute(
        currentPageKey: anyNamed('currentPageKey'),
      ),
    ).thenAnswer(
      (_) => TaskEither<ApodsError, ApodPage>.fromEither(
        Right(result ?? TestModels.apodPage()),
      ),
    );
  }

  void withFetchApodsUseCaseFailure({ApodsError? error}) {
    when(
      _builder.fetchApodsUseCase.execute(
        currentPageKey: anyNamed('currentPageKey'),
      ),
    ).thenAnswer(
      (_) => TaskEither<ApodsError, ApodPage>.fromEither(
        Left(error ?? TestModels.apodsError()),
      ),
    );
  }

  ApodsListCubit createTested() =>
      ApodsListCubit(fetchApodsUseCase: fetchApodsUseCase);
}
