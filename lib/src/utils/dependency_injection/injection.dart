import 'package:bloc/bloc.dart';
import 'package:hello_universe/src/disposable.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector.dart';

/// Base class for injecting dependencies.
abstract class Injection<T> {
  Injection() : stackTrace = StackTrace.current;

  final StackTrace stackTrace;

  Type get injectionType => T;
}

/// Injection that creates instances each time it resolved.
class FactoryInjection<T> extends Injection<T> {
  FactoryInjection(this._create);

  final T Function(Injector resolver) _create;

  T create(Injector resolver) {
    final value = _create(resolver);

    if (value is Disposable) {
      throw StateError(
        '$Disposable object of exact type ${value.runtimeType} should not be factory injected.\n'
        'We cannot guarantee that the object will be disposed when it is no longer needed.\n'
        'Please change to SingletonInjection<$T>.\n'
        'Example:\n'
        'SingletonInjection<$T>((resolver) => ...)\n',
      );
    }

    return value;
  }
}

/// Injection that creates instances each time it resolved with additional
/// parameters as an inputs.
class AssistedFactoryInjection<T, P> extends Injection<T> {
  AssistedFactoryInjection(this._create);

  final T Function(Injector resolver, P params) _create;

  T create(Injector resolver, P params) {
    final value = _create(resolver, params);

    if (value is Disposable) {
      throw StateError(
        '$Disposable object of exact type ${value.runtimeType} should not be factory injected.\n'
        'We cannot guarantee that the object will be disposed when it is no longer needed.\n'
        'Please change to AssistedSingletonInjection<$T, $P>.\n'
        'Example:\n'
        'AssistedSingletonInjection<$T, $P>((resolver, params) => ...)\n',
      );
    }

    return value;
  }
}

/// Injection that creates Singleton object the first time it got resolved and
/// consequent resolves return created previously instance.
class SingletonInjection<T> extends Injection<T> {
  SingletonInjection(this._create);

  final T Function(Injector resolver) _create;

  T create(Injector resolver) {
    final value = _create(resolver);

    if (value is BlocBase) {
      throw StateError(
        '$BlocBase object if exact type ${value.runtimeType} should not be singleton injected.\n'
        'Please change to FactoryInjection<$T>.\n'
        'Example:\n'
        'FactoryInjection<$T>((resolver) => ...)\n',
      );
    }

    return value;
  }
}

/// Injection that creates Singleton object the first time it got resolved and
/// consequent resolves return created previously instance.
class AssistedSingletonInjection<T, P> extends Injection<T> {
  AssistedSingletonInjection(this._create);

  final T Function(Injector resolver, P params) _create;

  T create(Injector resolver, P params) {
    final value = _create(resolver, params);

    if (value is BlocBase) {
      throw StateError(
        '$BlocBase object if exact type ${value.runtimeType} should not be factory injected.\n'
        'Please change to AssistedFactoryInjection<$T, $P>.\n'
        'Example:\n'
        'AssistedFactoryInjection<$T, $P>((resolver, params) => ...)\n',
      );
    }

    return value;
  }
}
