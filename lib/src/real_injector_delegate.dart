import 'package:hello_universe/src/utils/dependency_injection/injection.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate.dart';
import 'package:hello_universe/src/repository/base_repository.dart';
import 'package:hello_universe/src/repository/impl_repository.dart';

/// Dependency graph for the app.
class RealInjectorDelegate extends InjectorDelegate {
  RealInjectorDelegate._(Injector resolver) : super(resolver);

  factory RealInjectorDelegate() {
    final injections = [..._createInjections];
    final resolver = Injector(injections);

    return RealInjectorDelegate._(resolver);
  }

  static List<Injection> get _createInjections => [
    SingletonInjection<BaseRepository>((_) => ImplRepository()),
  ];
}
