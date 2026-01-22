import 'package:bloc/bloc.dart';
import 'package:hello_universe/src/utils/disposable.dart';
import 'package:hello_universe/src/utils/dependency_injection/injection.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

void main() {
  group('factory injection', () {
    test('is created', () async {
      final injection = FactoryInjection<String>((resolver) => 'test');

      expect(injection.create(_MockInjector()), isNotNull);
    });

    test('throws when disposable object is injected', () async {
      final injection = FactoryInjection<Disposable>(
        (resolver) => DisposableImpl(),
      );

      expect(
        () => injection.create(_MockInjector()),
        throwsA(isA<StateError>()),
      );
    });

    test(
      'throws verbose error message when disposable object is injected',
      () async {
        final injection = FactoryInjection<Disposable>(
          (resolver) => DisposableImpl(),
        );

        expect(
          () => injection.create(_MockInjector()),
          throwsA(
            isA<StateError>().having(
              (e) => e.toString(),
              'toString',
              contains(
                'Disposable object of exact type DisposableImpl should not be factory injected.',
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
          (resolver) => BlocBaseImpl(''),
        );

        expect(injection.create(_MockInjector()), isNotNull);
      },
    );
  });

  group('assisted factory injection', () {
    test('is created', () async {
      final injection = AssistedFactoryInjection<String, String>(
        (resolver, param) => 'test 1',
      );

      expect(injection.create(_MockInjector(), 'test 2'), isNotNull);
    });

    test('throws when disposable object is injected', () async {
      final injection = AssistedFactoryInjection<Disposable, String>(
        (resolver, param) => DisposableImpl(),
      );

      expect(
        () => injection.create(_MockInjector(), 'test'),
        throwsA(isA<StateError>()),
      );
    });

    test(
      'throws verbose error message when disposable object is injected',
      () async {
        final injection = AssistedFactoryInjection<Disposable, String>(
          (resolver, param) => DisposableImpl(),
        );

        expect(
          () => injection.create(_MockInjector(), 'test'),
          throwsA(
            isA<StateError>().having(
              (e) => e.toString(),
              'toString',
              contains(
                'Disposable object of exact type DisposableImpl should not be factory injected',
              ),
            ),
          ),
        );
      },
    );

    test('throws when object implementing disposable is injected', () async {
      final injection = AssistedFactoryInjection<DisposableImpl, String>(
        (resolver, param) => DisposableImpl(),
      );

      expect(
        () => injection.create(_MockInjector(), 'test'),
        throwsA(isA<StateError>()),
      );
    });

    test(
      'returns normally for block as it will be disposed in its scope',
      () async {
        final injection = AssistedFactoryInjection<BlocBase, String>(
          (resolver, param) => BlocBaseImpl(''),
        );

        expect(injection.create(_MockInjector(), 'test'), isNotNull);
      },
    );
  });

  group('singleton injection', () {
    test('is created', () async {
      final injection = SingletonInjection<String>((resolver) => 'test');

      expect(injection.create(_MockInjector()), isNotNull);
    });

    test(
      'returns normally for disposable as it will be disposed automatically',
      () async {
        final injection = SingletonInjection<Disposable>(
          (resolver) => DisposableImpl(),
        );

        expect(() => injection.create(_MockInjector()), isNotNull);
      },
    );

    test('throws as blocks should be factory injected', () async {
      final injection = SingletonInjection<BlocBase>(
        (resolver) => BlocBaseImpl(''),
      );

      expect(
        () => injection.create(_MockInjector()),
        throwsA(isA<StateError>()),
      );
    });

    test('throws verbose error message when bloc object is injected', () async {
      final injection = SingletonInjection<BlocBase>(
        (resolver) => BlocBaseImpl(''),
      );

      expect(
        () => injection.create(_MockInjector()),
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

      expect(injection.create(_MockInjector(), ''), isNotNull);
    });

    test(
      'returns normally for disposable as it will be disposed automatically',
      () async {
        final injection = AssistedSingletonInjection<Disposable, String>(
          (resolver, _) => DisposableImpl(),
        );

        expect(() => injection.create(_MockInjector(), ''), isNotNull);
      },
    );

    test('throws as blocks should be factory injected', () async {
      final injection = AssistedSingletonInjection<BlocBase, String>(
        (resolver, _) => BlocBaseImpl(''),
      );

      expect(
        () => injection.create(_MockInjector(), ''),
        throwsA(isA<StateError>()),
      );
    });

    test('throws verbose error message when bloc object is injected', () async {
      final injection = AssistedSingletonInjection<BlocBase, String>(
        (resolver, _) => BlocBaseImpl(''),
      );

      expect(
        () => injection.create(_MockInjector(), ''),
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

class DisposableImpl implements Disposable {
  @override
  void dispose() {}
}

class BlocBaseImpl extends BlocBase {
  BlocBaseImpl(super._state);
}

class _MockInjector extends Mock implements Injector {}
