// ignore_for_file: avoid_print
import 'package:hello_universe/src/utils/disposable.dart';
import 'package:hello_universe/src/utils/dependency_injection/injection.dart';

/// Used to resolve dependencies.
class Injector implements Disposable {
  final _values = <Type, Object>{};
  final _injections = <Type, Injection>{};

  Injector(List<Injection> injections) {
    injections.forEach((creator) {
      final dependencyType = creator.injectionType;
      final exists = _injections.containsKey(dependencyType);

      if (exists) {
        assert(() {
          print('Injection for $dependencyType is already defined\n');
          return true;
        }());
      }

      _injections[dependencyType] = creator;
    });
  }

  /// Resolves the injection by type.
  /// If you need to resolve with parameters use [resolveWithParams] method.
  T resolve<T extends Object>() {
    final value = _values[T];
    if (value != null) {
      if (value is T) {
        return value;
      } else {
        throw StateError(
          'Value "$value" of type "${value.runtimeType}" is stored where type "$T" is expected',
        );
      }
    }

    final creator = _injections[T];
    if (creator == null) {
      throw StateError(
        'The client has requested type "$T", but it is not injected.',
      );
    }

    if (creator is SingletonInjection<T>) {
      return _values[T] = creator.create(this);
    } else if (creator is FactoryInjection<T>) {
      return creator.create(this);
    } else {
      throw StateError(
        'Injection type is ${creator.runtimeType} is where Injection<$T> is expected',
      );
    }
  }

  /// Resolves the injection by type with provided [params].
  /// If you need to resolve without parameters use [resolve] method.
  T resolveWithParams<T extends Object, P extends Object?>(P params) {
    final value = _values[T];
    if (value != null) {
      if (value is T) {
        return value;
      } else {
        throw StateError(
          'Value "$value" of type "${value.runtimeType}" is stored where type "$T" is expected',
        );
      }
    }

    final creator = _injections[T];
    if (creator == null) {
      throw StateError(
        'The client has requested type "$T" with params "$params", but it is not injected.',
      );
    }

    if (creator is AssistedFactoryInjection<T, P>) {
      return creator.create(this, params);
    } else if (creator is AssistedSingletonInjection<T, P>) {
      return _values[T] = creator.create(this, params);
    } else {
      throw StateError(
        'Injection type is ${creator.runtimeType} is where Injection<$T> is expected',
      );
    }
  }

  @override
  void dispose() {
    for (final value in _values.values) {
      if (value is Disposable) {
        value.dispose();
      }
    }
    _values.clear();
  }
}
