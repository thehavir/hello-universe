import 'package:chopper/chopper.dart';
import 'package:chopper_built_value/chopper_built_value.dart';
import 'package:hello_universe/src/data/apod_service.dart';
import 'package:hello_universe/src/data/serializer.dart';
import 'package:hello_universe/src/repository/base_repository.dart';
import 'package:hello_universe/src/repository/impl_repository.dart';
import 'package:hello_universe/src/utils/dependency_injection/injection.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate.dart';

/// Dependency graph for the app.
class RealInjectorDelegate extends InjectorDelegate {
  RealInjectorDelegate._({required Injector resolver}) : super(resolver);

  factory RealInjectorDelegate() {
    final injections = [..._createInjections];
    final resolver = Injector(injections);

    return RealInjectorDelegate._(resolver: resolver);
  }

  static List<Injection> get _createInjections => [
    SingletonInjection<BaseRepository>((resolver) => ImplRepository()),
    SingletonInjection<ApodServiceProvider>(
      (resolver) => RealApodServiceProvider(chopperClient: resolver.resolve()),
    ),
    SingletonInjection<ApodService>(
      (resolver) => resolver.resolve<ApodServiceProvider>().create(),
    ),
    SingletonInjection<ChopperClient>(
      (_) => ChopperClient(
        baseUrl: Uri.parse('https://api.nasa.gov/'),
        converter: BuiltValueConverter(serializers),
      ),
    ),
  ];
}
