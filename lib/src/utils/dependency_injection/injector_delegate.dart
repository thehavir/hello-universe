import 'package:hello_universe/src/utils/dependency_injection/injector.dart';

class InjectorDelegate implements Injector {
  const InjectorDelegate(this._injector);

  final Injector _injector;

  @override
  T resolve<T extends Object>() => _injector.resolve<T>();

  @override
  T resolveWithParams<T extends Object, P extends Object?>(P params) =>
      _injector.resolveWithParams<T, P>(params);

  @override
  void dispose() => _injector.dispose();
}
