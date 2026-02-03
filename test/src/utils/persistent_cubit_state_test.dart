import 'package:equatable/equatable.dart';
import 'package:hello_universe/src/utils/persistent_cubit_state.dart';
import 'package:test/test.dart';

void main() {
  const _testData = _TestData(name: 'Spinoza');
  const _testError =
      'Many errors, of a truth, consist merely in the application of the wrong names of things.';

  group('loading state', () {
    test('can be created', () {
      const state = PersistentLoadingCubitState<_TestData, Object>(
        data: _testData,
      );

      expect(state, isA<PersistentLoadingCubitState>());
    });

    test('has data when it is passed', () {
      const state = PersistentLoadingCubitState<_TestData, Object>(
        data: _testData,
      );

      expect(state.data, _testData);
    });

    test('data is null when it is not passed', () {
      const state = PersistentLoadingCubitState<_TestData, Object>();

      expect(state.data, isNull);
    });

    test('two different instances are equal', () {
      const state1 = PersistentLoadingCubitState<_TestData, Object>(
        data: _testData,
      );
      const state2 = PersistentLoadingCubitState<_TestData, Object>(
        data: _testData,
      );

      expect(state1, state2);
    });

    group('toLoading', () {
      test('returns loading state', () {
        const state = PersistentLoadingCubitState<_TestData, Object>();

        final tested = state.toLoading();

        expect(tested, isA<PersistentLoadingCubitState>());
      });

      test('returns loading state with new data when it is passed', () {
        const newData = _TestData(name: 'new data');
        const state = PersistentLoadingCubitState<_TestData, Object>(
          data: _testData,
        );

        final tested = state.toLoading(newData: newData);

        expect(tested.data, newData);
      });

      test(
        'returns loading state with previous data when it is not passed',
        () {
          const state = PersistentLoadingCubitState<_TestData, Object>(
            data: _testData,
          );

          final tested = state.toLoading();

          expect(tested.data, _testData);
        },
      );
    });

    group('toError', () {
      test('returns error state with error', () {
        const state = PersistentLoadingCubitState<_TestData, Object>();

        final tested = state.toError(_testError);

        expect(
          tested,
          isA<PersistentErrorCubitState>().having(
            (state) => state.error,
            'error',
            _testError,
          ),
        );
      });

      test('returns error state with new data when it is passed', () {
        const newData = _TestData(name: 'new data');
        const state = PersistentLoadingCubitState<_TestData, Object>(
          data: _testData,
        );

        final tested = state.toError(_testError, newData: newData);

        expect(tested.data, newData);
      });

      test('returns error state with previous data when it is not passed', () {
        const state = PersistentLoadingCubitState<_TestData, Object>(
          data: _testData,
        );

        final tested = state.toError(_testError);

        expect(tested.data, _testData);
      });
    });

    test('to loaded returns loaded state', () {
      const state = PersistentLoadingCubitState<_TestData, Object>();

      final tested = state.toLoaded(_testData);

      expect(
        tested,
        isA<PersistentLoadedCubitState>().having(
          (state) => state.data,
          'data',
          _testData,
        ),
      );
    });
  });

  group('error state', () {
    test('can be created', () {
      const state = PersistentErrorCubitState<_TestData, Object>(_testError);

      expect(state, isA<PersistentErrorCubitState>());
    });

    test('has error', () {
      const state = PersistentErrorCubitState<_TestData, Object>(_testError);

      expect(state.error, _testError);
    });

    test('has data when it is passed', () {
      const state = PersistentErrorCubitState<_TestData, Object>(
        _testError,
        data: _testData,
      );

      expect(state.data, _testData);
    });

    test('data is null when it is not passed', () {
      const state = PersistentErrorCubitState<_TestData, Object>(_testError);

      expect(state.data, isNull);
    });

    test('two different instances are equal', () {
      const state1 = PersistentErrorCubitState<_TestData, Object>(_testError);
      const state2 = PersistentErrorCubitState<_TestData, Object>(_testError);

      expect(state1, state2);
    });

    group('toLoading', () {
      test('returns loading state', () {
        const state = PersistentErrorCubitState<_TestData, Object>(_testError);

        final tested = state.toLoading();

        expect(tested, isA<PersistentLoadingCubitState>());
      });

      test('returns loading state with new data when it is passed', () {
        const newData = _TestData(name: 'new data');
        const state = PersistentErrorCubitState<_TestData, Object>(
          _testError,
          data: _testData,
        );

        final tested = state.toLoading(newData: newData);

        expect(tested.data, newData);
      });

      test(
        'returns loading state with previous data when it is not passed',
        () {
          const state = PersistentErrorCubitState<_TestData, Object>(
            _testError,
            data: _testData,
          );

          final tested = state.toLoading();

          expect(tested.data, _testData);
        },
      );
    });

    group('toError', () {
      test('returns error state with error', () {
        const state = PersistentErrorCubitState<_TestData, Object>(_testError);

        final tested = state.toError(_testError);

        expect(
          tested,
          isA<PersistentErrorCubitState>().having(
            (state) => state.error,
            'error',
            _testError,
          ),
        );
      });

      test('returns error state with new data when it is passed', () {
        const newData = _TestData(name: 'new data');
        const state = PersistentErrorCubitState<_TestData, Object>(
          _testError,
          data: _testData,
        );

        final tested = state.toError(_testError, newData: newData);

        expect(tested.data, newData);
      });

      test('returns error state with previous data when it is not passed', () {
        const state = PersistentErrorCubitState<_TestData, Object>(
          _testError,
          data: _testData,
        );

        final tested = state.toError(_testError);

        expect(tested.data, _testData);
      });
    });

    test('to loaded returns loaded state', () {
      const state = PersistentErrorCubitState<_TestData, Object>(_testError);

      final tested = state.toLoaded(_testData);

      expect(
        tested,
        isA<PersistentLoadedCubitState>().having(
          (state) => state.data,
          'data',
          _testData,
        ),
      );
    });
  });

  group('loaded state', () {
    test('can be created', () {
      const state = PersistentLoadedCubitState<_TestData, Object>(_testData);

      expect(state, isA<PersistentLoadedCubitState>());
    });

    test('has data', () {
      const state = PersistentLoadedCubitState<_TestData, Object>(_testData);

      expect(state.data, _testData);
    });

    test('two different instances are equal', () {
      const state1 = PersistentLoadedCubitState<_TestData, Object>(_testData);
      const state2 = PersistentLoadedCubitState<_TestData, Object>(_testData);

      expect(state1, state2);
    });

    group('toLoading', () {
      test('returns loading state', () {
        const state = PersistentLoadedCubitState<_TestData, Object>(_testData);

        final tested = state.toLoading();

        expect(tested, isA<PersistentLoadingCubitState>());
      });

      test('returns loading state with new data when it is passed', () {
        const newData = _TestData(name: 'new data');
        const state = PersistentLoadedCubitState<_TestData, Object>(_testData);

        final tested = state.toLoading(newData: newData);

        expect(tested.data, newData);
      });

      test(
        'returns loading state with previous data when it is not passed',
        () {
          const state = PersistentLoadedCubitState<_TestData, Object>(
            _testData,
          );

          final tested = state.toLoading();

          expect(tested.data, _testData);
        },
      );
    });

    group('toError', () {
      test('returns error state with error', () {
        const state = PersistentLoadedCubitState<_TestData, Object>(_testData);

        final tested = state.toError(_testError);

        expect(
          tested,
          isA<PersistentErrorCubitState>().having(
            (state) => state.error,
            'error',
            _testError,
          ),
        );
      });

      test('returns error state with new data when it is passed', () {
        const newData = _TestData(name: 'new data');
        const state = PersistentLoadedCubitState<_TestData, Object>(_testData);

        final tested = state.toError(_testError, newData: newData);

        expect(tested.data, newData);
      });

      test('returns error state with previous data when it is not passed', () {
        const state = PersistentLoadedCubitState<_TestData, Object>(_testData);

        final tested = state.toError(_testError);

        expect(tested.data, _testData);
      });
    });

    test('to loaded returns loaded state with new data', () {
      const newData = _TestData(name: 'new data');
      const state = PersistentLoadedCubitState<_TestData, Object>(_testData);

      final tested = state.toLoaded(newData);

      expect(
        tested,
        isA<PersistentLoadedCubitState>().having(
          (state) => state.data,
          'data',
          newData,
        ),
      );
    });
  });
}

class _TestData extends Equatable {
  final String name;

  const _TestData({required this.name});

  @override
  List<Object?> get props => [name];
}
