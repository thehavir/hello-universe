import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  test('resolve is delegated', () {
    var called = false;
    final resolver = _MockedDependencyResolver();
    when(() => resolver.resolve<String>()).thenAnswer((_) {
      called = true;
      return '';
    });
    final resolverDelegate = InjectorDelegate(resolver);

    // ignore: cascade_invocations
    resolverDelegate.resolve<String>();

    expect(called, isTrue);
  });

  test('resolveWithParams is delegated', () {
    var called = false;
    final resolver = _MockedDependencyResolver();
    when(() => resolver.resolveWithParams<String, int>(any())).thenAnswer((_) {
      called = true;
      return '';
    });
    final resolverDelegate = InjectorDelegate(resolver);

    // ignore: cascade_invocations
    resolverDelegate.resolveWithParams<String, int>(0);

    expect(called, isTrue);
  });

  test('resolveWithParams is delegated with null parameter value', () {
    var called = false;
    final resolver = _MockedDependencyResolver();
    when(() => resolver.resolveWithParams<String, int?>(any())).thenAnswer((_) {
      called = true;
      return '';
    });
    final resolverDelegate = InjectorDelegate(resolver);

    // ignore: cascade_invocations
    resolverDelegate.resolveWithParams<String, int?>(null);

    expect(called, isTrue);
  });
}

class _MockedDependencyResolver extends Mock implements Injector {}
