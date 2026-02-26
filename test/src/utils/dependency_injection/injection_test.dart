import 'package:bloc/bloc.dart';
import 'package:hello_universe/src/utils/disposable.dart';
import 'package:hello_universe/src/utils/dependency_injection/injection.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import 'injection_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Injector>()])
void main() {
  late MockInjector injector;

  setUp(() => injector = MockInjector());

  group('factory injection', () {
    test('is created', () async {
      final injection = FactoryInjection<String>((resolver) => 'test');

      expect(injection.create(injector), isNotNull);
    });

    test('throws when disposable object is injected', () async {
      final injection = FactoryInjection<Disposable>(
        (resolver) => _TestDisposableImpl(),
      );

      expect(() => injection.create(injector), throwsA(isA<StateError>()));
    });

    test(
      'throws verbose error message when disposable object is injected',
      () async {
        final injection = FactoryInjection<Disposable>(
          (resolver) => _TestDisposableImpl(),
        );

        expect(
          () => injection.create(injector),
          throwsA(
            isA<StateError>().having(
              (e) => e.toString(),
              'toString',
              contains(
                'Disposable object of exact type _TestDisposableImpl should not be factory injected.',
              ),
            ),
          ),
        );
      },
    );

    test(
      'returns normally for block as it will be disposed in its scope',
      () async {
        final injection = FactoryInjection<BlocBase>(
          (resolver) => _TestBaseImpl(''),
        );

        expect(injection.create(injector), isNotNull);
      },
    );
  });

  group('assisted factory injection', () {
    test('is created', () async {
      final injection = AssistedFactoryInjection<String, String>(
        (resolver, param) => 'test 1',
      );

      expect(injection.create(injector, 'test 2'), isNotNull);
    });

    test('throws when disposable object is injected', () async {
      final injection = AssistedFactoryInjection<Disposable, String>(
        (resolver, param) => _TestDisposableImpl(),
      );

      expect(
        () => injection.create(injector, 'test'),
        throwsA(isA<StateError>()),
      );
    });

    test(
      'throws verbose error message when disposable object is injected',
      () async {
        final injection = AssistedFactoryInjection<Disposable, String>(
          (resolver, param) => _TestDisposableImpl(),
        );

        expect(
          () => injection.create(injector, 'test'),
          throwsA(
            isA<StateError>().having(
              (e) => e.toString(),
              'toString',
              contains(
                'Disposable object of exact type _TestDisposableImpl should not be factory injected',
              ),
            ),
          ),
        );
      },
    );

    test('throws when object implementing disposable is injected', () async {
      final injection = AssistedFactoryInjection<_TestDisposableImpl, String>(
        (resolver, param) => _TestDisposableImpl(),
      );

      expect(
        () => injection.create(injector, 'test'),
        throwsA(isA<StateError>()),
      );
    });

    test(
      'returns normally for block as it will be disposed in its scope',
      () async {
        final injection = AssistedFactoryInjection<BlocBase, String>(
          (resolver, param) => _TestBaseImpl(''),
        );

        expect(injection.create(injector, 'test'), isNotNull);
      },
    );
  });

  group('singleton injection', () {
    test('is created', () async {
      final injection = SingletonInjection<String>((resolver) => 'test');

      expect(injection.create(injector), isNotNull);
    });

    test(
      'returns normally for disposable as it will be disposed automatically',
      () async {
        final injection = SingletonInjection<Disposable>(
          (resolver) => _TestDisposableImpl(),
        );

        expect(() => injection.create(injector), isNotNull);
      },
    );

    test('throws as blocks should be factory injected', () async {
      final injection = SingletonInjection<BlocBase>(
        (resolver) => _TestBaseImpl(''),
      );

      expect(() => injection.create(injector), throwsA(isA<StateError>()));
    });

    test('throws verbose error message when bloc object is injected', () async {
      final injection = SingletonInjection<BlocBase>(
        (resolver) => _TestBaseImpl(''),
      );

      expect(
        () => injection.create(injector),
        throwsA(
          isA<StateError>().having(
            (e) => e.toString(),
            'toString',
            contains('Please change to FactoryInjection'),
          ),
        ),
      );
    });
  });

  group('assisted singleton injection', () {
    test('is created', () async {
      final injection = AssistedSingletonInjection<String, String>(
        (resolver, _) => 'test',
      );

      expect(injection.create(injector, ''), isNotNull);
    });

    test(
      'returns normally for disposable as it will be disposed automatically',
      () async {
        final injection = AssistedSingletonInjection<Disposable, String>(
          (resolver, _) => _TestDisposableImpl(),
        );

        expect(() => injection.create(injector, ''), isNotNull);
      },
    );

    test('throws as blocks should be factory injected', () async {
      final injection = AssistedSingletonInjection<BlocBase, String>(
        (resolver, _) => _TestBaseImpl(''),
      );

      expect(() => injection.create(injector, ''), throwsA(isA<StateError>()));
    });

    test('throws verbose error message when bloc object is injected', () async {
      final injection = AssistedSingletonInjection<BlocBase, String>(
        (resolver, _) => _TestBaseImpl(''),
      );

      expect(
        () => injection.create(injector, ''),
        throwsA(
          isA<StateError>().having(
            (e) => e.toString(),
            'toString',
            contains('Please change to AssistedFactoryInjection'),
          ),
        ),
      );
    });
  });
}

class _TestDisposableImpl implements Disposable {
  @override
  void dispose() {}
}

class _TestBaseImpl extends BlocBase {
  _TestBaseImpl(super._state);
}
