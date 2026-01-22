import 'package:hello_universe/src/utils/dependency_injection/injection.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

const _testClass = _TestClass('Test Class');
const _anotherTestClass = _TestClass('Another Test Class');
const _name1 = 'Name1';
const _name2 = 'Name2';
const _name3 = 'Name3';

void main() {
  group('$SingletonInjection', () {
    test('resolves injected class', () {
      final injector = Injector([
        SingletonInjection<_TestClass>((_) => _anotherTestClass),
      ]);

      final testClass = injector.resolve<_TestClass>();

      expect(testClass, _anotherTestClass);
    });

    test('return cached value if it was accessed before', () {
      var calledOnce = false;
      final injector = Injector([
        SingletonInjection<_TestClass>((_) {
          if (calledOnce) {
            return _testClass;
          } else {
            calledOnce = true;
            return _anotherTestClass;
          }
        }),
      ]);

      final testClass1 = injector.resolve<_TestClass>();
      final testClass2 = injector.resolve<_TestClass>();

      expect([testClass1, testClass2], [_anotherTestClass, _anotherTestClass]);
    });
  });

  group('$FactoryInjection', () {
    test('resolves injected class', () {
      final injector = Injector([
        FactoryInjection<_TestClass>((_) => _anotherTestClass),
      ]);

      final testClass = injector.resolve<_TestClass>();

      expect(testClass, _anotherTestClass);
    });

    test('create new objects each time resolve was called', () {
      var calledOnce = false;
      final injector = Injector([
        FactoryInjection<_TestClass>((_) {
          if (!calledOnce) {
            calledOnce = true;
            return _anotherTestClass;
          } else {
            return _testClass;
          }
        }),
      ]);

      final testClass1 = injector.resolve<_TestClass>();
      final testClass2 = injector.resolve<_TestClass>();

      expect([testClass1, testClass2], [_anotherTestClass, _testClass]);
    });
  });

  group('$AssistedSingletonInjection', () {
    test('resolves injected class', () {
      final injector = Injector([
        AssistedSingletonInjection<_TestClass, String>(
          (_, name) => _TestClass('$_name1 $name'),
        ),
      ]);

      final testClass = injector.resolveWithParams<_TestClass, String>(_name2);

      expect(testClass, const _TestClass('$_name1 $_name2'));
    });

    test('create new object only the firs time it was resolved', () {
      final injector = Injector([
        AssistedSingletonInjection<_TestClass, String>(
          (_, name) => _TestClass('$_name1 $name'),
        ),
      ]);

      final testClass1 = injector.resolveWithParams<_TestClass, String>(_name2);
      final testClass2 = injector.resolveWithParams<_TestClass, String>(_name3);

      expect(
        [testClass1, testClass2],
        const [_TestClass('$_name1 $_name2'), _TestClass('$_name1 $_name2')],
      );
    });
  });

  group('$AssistedFactoryInjection', () {
    test('resolves injected class', () {
      final injector = Injector([
        AssistedFactoryInjection<_TestClass, String>(
          (_, name) => _TestClass('$_name1 $name'),
        ),
      ]);

      final testClass = injector.resolveWithParams<_TestClass, String>(_name2);

      expect(testClass, const _TestClass('$_name1 $_name2'));
    });

    test('create new objects each time resolve was called', () {
      final injector = Injector([
        AssistedFactoryInjection<_TestClass, String>(
          (_, name) => _TestClass('$_name1 $name'),
        ),
      ]);

      final testClass1 = injector.resolveWithParams<_TestClass, String>(_name2);
      final testClass2 = injector.resolveWithParams<_TestClass, String>(_name3);

      expect(
        [testClass1, testClass2],
        const [_TestClass('$_name1 $_name2'), _TestClass('$_name1 $_name3')],
      );
    });
  });

  group('Throws StateError', () {
    group('when creator was injected but', () {
      test('resolve() called for $AssistedFactoryInjection', () {
        final injector = Injector([
          AssistedFactoryInjection<_TestClass, String>(
            (_, params) => _TestClass(params),
          ),
        ]);

        final resolve = () => injector.resolve<_TestClass>();

        expect(resolve, throwsA(isA<StateError>()));
      });

      test('resolve() called for $AssistedSingletonInjection', () {
        final injector = Injector([
          AssistedSingletonInjection<_TestClass, String>(
            (_, params) => _TestClass(params),
          ),
        ]);

        final resolve = () => injector.resolve<_TestClass>();

        expect(resolve, throwsA(isA<StateError>()));
      });

      test('if resolveWithParams() called for $FactoryInjection', () {
        final injector = Injector([
          FactoryInjection<_TestClass>((_) => _anotherTestClass),
        ]);

        final resolve = () =>
            injector.resolveWithParams<_TestClass, String>('Name1 Name2');

        expect(resolve, throwsA(isA<StateError>()));
      });

      test('if resolveWithParams() called for $SingletonInjection', () {
        final injector = Injector([
          SingletonInjection<_TestClass>((_) => _anotherTestClass),
        ]);

        final resolve = () =>
            injector.resolveWithParams<_TestClass, String>('Name1 Name2');

        expect(resolve, throwsA(isA<StateError>()));
      });
    });

    group('when no creator were injected but', () {
      test('resolve() was called', () {
        final injector = Injector([]);

        final resolve = () => injector.resolve<_TestClass>();

        expect(resolve, throwsA(isA<StateError>()));
      });

      test('if resolveWithParams() was called', () {
        final injector = Injector([]);

        final resolve = () =>
            injector.resolveWithParams<_TestClass, String>('Name1 Name2');

        expect(resolve, throwsA(isA<StateError>()));
      });
    });

    test('with a descriptive message when no provider was found for resolve', () {
      final injector = Injector([]);

      final resolve = () => injector.resolve<_TestClass>();

      expect(
        resolve,
        throwsA(
          isA<StateError>().having(
            (e) => e.toString(),
            'toString',
            contains(
              'The client has requested type "_TestClass", but it is not injected',
            ),
          ),
        ),
      );
    });

    test(
      'with a descriptive message when no provider was found for resolveWithParams',
      () {
        final injector = Injector([]);

        final resolve = () =>
            injector.resolveWithParams<_TestClass, String>('Name1 Name2');

        expect(
          resolve,
          throwsA(
            isA<StateError>().having(
              (e) => e.toString(),
              'toString',
              contains(
                'The client has requested type "_TestClass" with params "Name1 Name2", but it is not injected',
              ),
            ),
          ),
        );
      },
    );
  });

  test('resolves with null parameter', () {
    final injector = Injector([
      AssistedSingletonInjection<_TestClass, String?>(
        (_, name) => _TestClass('$_name1 $name'),
      ),
    ]);

    final testClass = injector.resolveWithParams<_TestClass, String?>(null);

    expect(testClass, const _TestClass('$_name1 null'));
  });
}

@immutable
class _TestClass {
  final String? name;

  const _TestClass(this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _TestClass &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => '_Class{$name}';
}
