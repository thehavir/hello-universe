import 'package:equatable/equatable.dart';
import 'package:hello_universe/src/utils/cubit_state.dart';
import 'package:test/test.dart';

void main() {
  group('$LoadingCubitState', () {
    test('can be created', () {
      final state = CubitState.loading<void, Object>();

      expect(state, const LoadingCubitState<void, Object>());
    });

    test('two instances with same data are equal', () {
      final state1 = CubitState.loading<_FakeData, Object>();
      final state2 = CubitState.loading<_FakeData, Object>();

      expect(state1, state2);
    });

    test('to loading returns same loading state', () {
      final state = CubitState.loading<_FakeData, Object>();

      final tested = state.toLoading();

      expect(tested, state);
    });

    test('to error returns error state', () {
      final state = CubitState.loading<_FakeData, String>();

      final tested = state.toError('The error');

      expect(
        tested,
        isA<CubitState<_FakeData, void>>().having(
          (state) => state.match(
            onLoading: () => fail('expected error but got loading'),
            onError: (error) => error,
            onLoaded: (data) => fail('expected error state but got loaded'),
          ),
          'error',
          'The error',
        ),
      );
    });

    test('to loaded returns loaded state', () {
      final state = CubitState.loading<_FakeData, Object>();

      final tested = state.toLoaded(_defaultFakeData);

      expect(
        tested,
        isA<CubitState<_FakeData, void>>().having(
          (state) => state.match(
            onLoading: () => fail('expected loaded but got loading'),
            onError: (error) => fail('expected loaded but got error'),
            onLoaded: (data) => data,
          ),
          'data',
          _defaultFakeData,
        ),
      );
    });

    test('match executes onLoading callback', () {
      final state = CubitState.loading<_FakeData, Object>();

      final tested = state.match(
        onLoading: () => 'loading...',
        onError: (error) => fail('expected loading but got error'),
        onLoaded: (data) => fail('expected loading but got loaded'),
      );

      expect(tested, 'loading...');
    });
  });

  group('$ErrorCubitState', () {
    test('can be created', () {
      final state = CubitState.error<void, String>('error1');

      expect(state, const ErrorCubitState<void, String>('error1'));
    });

    test('two instances with same data are equal', () {
      final state1 = CubitState.error<_FakeData, String>('error1');
      final state2 = CubitState.error<_FakeData, String>('error1');

      expect(state1, state2);
    });

    test('is created with correct values', () {
      final state = CubitState.error<_FakeData, String>('The error');

      expect(
        state,
        isA<CubitState<_FakeData, String>>().having(
          (state) => state.match(
            onLoading: () => fail('expected error but got loading'),
            onError: (error) => error,
            onLoaded: (data) => fail('expected error but got loaded'),
          ),
          'error',
          'The error',
        ),
      );
    });

    test('to loading returns loading state', () {
      final state = CubitState.error<_FakeData, String>('error1');

      final tested = state.toLoading();

      expect(tested, isA<LoadingCubitState<_FakeData, String>>());
    });

    test('to error returns same error state', () {
      final state = CubitState.error<_FakeData, String>('error1');

      final tested = state.toError('error1');

      expect(tested, state);
    });

    test('to loaded returns loaded state', () {
      final state = CubitState.error<_FakeData, String>('error');

      final tested = state.toLoaded(_defaultFakeData);

      expect(
        tested,
        isA<CubitState<_FakeData, void>>().having(
          (state) => state.match(
            onLoading: () => fail('expected loaded but got loading'),
            onError: (error) => fail('expected loaded but got error'),
            onLoaded: (data) => data,
          ),
          'data',
          _defaultFakeData,
        ),
      );
    });

    test('match executes onError callback', () {
      final state = CubitState.error<_FakeData, String>('error-x2');

      final tested = state.match(
        onLoading: () => fail('expected error but got loading'),
        onError: (error) => 'error-x2',
        onLoaded: (data) => fail('expected error but got loaded'),
      );

      expect(tested, 'error-x2');
    });
  });

  group('$LoadedCubitState', () {
    test('can be created', () {
      final state = CubitState.loaded<_FakeData, Object>(_defaultFakeData);

      expect(
        state,
        const LoadedCubitState<_FakeData, Object>(_defaultFakeData),
      );
    });

    test('two instances with same data are equal', () {
      final state1 = CubitState.loaded<_FakeData, Object>(_defaultFakeData);
      final state2 = CubitState.loaded<_FakeData, Object>(_defaultFakeData);

      expect(state1, state2);
    });

    test('is created with correct values', () {
      final state = CubitState.loaded<_FakeData, String>(_defaultFakeData);

      expect(
        state,
        isA<CubitState<_FakeData, String>>().having(
          (state) => state.match(
            onLoading: () => fail('expected loaded but got loading'),
            onError: (error) => fail('expected loaded but got error'),
            onLoaded: (data) => data,
          ),
          'data',
          _defaultFakeData,
        ),
      );
    });

    test('to loading returns loading state', () {
      final state = CubitState.loaded<_FakeData, Object>(_defaultFakeData);

      final tested = state.toLoading();

      expect(tested, isA<LoadingCubitState<_FakeData, Object>>());
    });

    test('to error returns error state', () {
      final state = CubitState.loaded<_FakeData, Object>(_defaultFakeData);

      final tested = state.toError('The error');

      expect(
        tested,
        isA<CubitState<_FakeData, Object>>().having(
          (state) => state.match(
            onLoading: () => fail('expected error but got loading'),
            onError: (error) => error,
            onLoaded: (data) => fail('expected error but got loaded'),
          ),
          'error',
          'The error',
        ),
      );
    });

    test('to loaded returns same loaded state', () {
      final state = CubitState.loaded<_FakeData, Object>(_defaultFakeData);

      final tested = state.toLoaded(_defaultFakeData);

      expect(tested, state);
    });

    test('match executes onLoaded callback', () {
      final state = CubitState.loaded<_FakeData, String>(_defaultFakeData);

      final tested = state.match<_FakeData>(
        onLoading: () => fail('onLoading should not have been executed'),
        onError: (error) => fail('onError should not have been executed'),
        onLoaded: (data) => data,
      );

      expect(tested, equals(_defaultFakeData));
    });
  });
}

const _defaultFakeData = _FakeData(bobsName: 'Bob');

class _FakeData extends Equatable {
  final String bobsName;

  const _FakeData({required this.bobsName});

  @override
  List<Object?> get props => [bobsName];
}
