import 'package:equatable/equatable.dart';
import 'package:hello_universe/src/utils/cubit_state.dart';
import 'package:test/test.dart';

void main() {
  const _testData = _TestData(name: 'Spinoza');
  const _testError =
      'Many errors, of a truth, consist merely in the application of the wrong names of things.';

  group('$LoadingCubitState', () {
    test('can be created', () {
      const state = LoadingCubitState<void, Object>();

      expect(state, const LoadingCubitState<void, Object>());
    });

    test('two instances with same data are equal', () {
      const state1 = LoadingCubitState<void, Object>();
      const state2 = LoadingCubitState<void, Object>();

      expect(state1, state2);
    });

    test('to loading returns same loading state', () {
      const state = LoadingCubitState<void, Object>();

      final tested = state.toLoading();

      expect(tested, state);
    });

    test('to error returns error state', () {
      const state = LoadingCubitState<void, Object>();

      final tested = state.toError(_testError);

      expect(
        tested,
        isA<ErrorCubitState>().having(
          (state) => state.error,
          'error',
          _testError,
        ),
      );
    });

    test('to loaded returns loaded state', () {
      const state = LoadingCubitState<void, Object>();

      final tested = state.toLoaded(_testData);

      expect(
        tested,
        isA<LoadedCubitState>().having(
          (state) => state.data,
          'data',
          _testData,
        ),
      );
    });
  });

  group('$ErrorCubitState', () {
    test('can be created', () {
      const state = ErrorCubitState<void, Object>(_testError);

      expect(
        state,
        isA<ErrorCubitState>().having(
          (state) => state.error,
          'error',
          _testError,
        ),
      );
    });

    test('two instances with same error are equal', () {
      const state1 = ErrorCubitState<void, Object>(_testError);
      const state2 = ErrorCubitState<void, Object>(_testError);

      expect(state1, state2);
    });

    test('to loading returns loading state', () {
      const state = ErrorCubitState<void, Object>(_testError);

      final tested = state.toLoading();

      expect(tested, isA<LoadingCubitState>());
    });

    test('to error returns error state with the new error', () {
      const newError = 'new error22';
      const state = ErrorCubitState<void, Object>(_testError);

      final tested = state.toError(newError);

      expect(
        tested,
        isA<ErrorCubitState>().having(
          (state) => state.error,
          'error',
          newError,
        ),
      );
    });

    test('to loaded returns loaded state', () {
      const state = ErrorCubitState<void, Object>(_testError);

      final tested = state.toLoaded(_testData);

      expect(
        tested,
        isA<LoadedCubitState>().having(
          (state) => state.data,
          'data',
          _testData,
        ),
      );
    });
  });

  group('$LoadedCubitState', () {
    test('can be created', () {
      const state = LoadedCubitState<_TestData, Object>(_testData);

      expect(
        state,
        isA<LoadedCubitState>().having(
          (state) => state.data,
          'data',
          _testData,
        ),
      );
    });

    test('two instances with same data are equal', () {
      const state1 = LoadedCubitState<_TestData, Object>(_testData);
      const state2 = LoadedCubitState<_TestData, Object>(_testData);

      expect(state1, state2);
    });

    test('to loading returns loading state', () {
      const state = LoadedCubitState<_TestData, Object>(_testData);

      final tested = state.toLoading();

      expect(tested, isA<LoadingCubitState>());
    });

    test('to error returns error state', () {
      const state = LoadedCubitState<_TestData, Object>(_testData);

      final tested = state.toError(_testError);

      expect(
        tested,
        isA<ErrorCubitState>().having(
          (state) => state.error,
          'error',
          _testError,
        ),
      );
    });

    test('to loaded returns loaded state with the new data', () {
      const newData = _TestData(name: 'new data44');
      const state = LoadedCubitState<_TestData, Object>(_testData);

      final tested = state.toLoaded(newData);

      expect(
        tested,
        isA<LoadedCubitState>().having((state) => state.data, 'data', newData),
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
