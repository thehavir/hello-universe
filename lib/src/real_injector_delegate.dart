import 'package:chopper/chopper.dart';
import 'package:chopper_built_value/chopper_built_value.dart';
import 'package:hello_universe/src/data/apod_service.dart';
import 'package:hello_universe/src/data/api_config_interceptor.dart';
import 'package:hello_universe/src/data/apods_repository_impl.dart';
import 'package:hello_universe/src/data/serializer.dart';
import 'package:hello_universe/src/domain/apods_pagination_handler.dart';
import 'package:hello_universe/src/domain/apods_repository.dart';
import 'package:hello_universe/src/domain/fetch_apods_use_case.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_cubit.dart';
import 'package:hello_universe/src/utils/dependency_injection/injection.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate.dart';
import 'package:clock/clock.dart';

/// Dependency graph for the app.
class RealInjectorDelegate extends InjectorDelegate {
  RealInjectorDelegate._({required Injector resolver}) : super(resolver);

  factory RealInjectorDelegate() {
    final injections = [..._createInjections];
    final resolver = Injector(injections);

    return RealInjectorDelegate._(resolver: resolver);
  }

  static List<Injection> get _createInjections => [
    SingletonInjection<ApodServiceProvider>(
      (resolver) => RealApodServiceProvider(chopperClient: resolver.resolve()),
    ),
    SingletonInjection<ApodService>(
      (resolver) => resolver.resolve<ApodServiceProvider>().create(),
    ),
    SingletonInjection<ChopperClient>(
      (resolver) => ChopperClient(
        baseUrl: Uri.parse('https://api.nasa.gov/'),
        converter: BuiltValueConverter(serializers),
        interceptors: [resolver.resolve<ConfigRequestInterceptor>()],
      ),
    ),
    SingletonInjection<ConfigRequestInterceptor>(
      (_) => const ConfigRequestInterceptorImpl(),
    ),
    SingletonInjection<ApodsRepository>(
      (resolver) => ApodsRepositoryImpl(
        apodService: resolver.resolve<ApodServiceProvider>().create(),
      ),
    ),
    SingletonInjection<Clock>((_) => const Clock()),
    SingletonInjection<ApodsPaginationHandler>(
      (resolver) => ApodsPaginationHandlerImpl(clock: resolver.resolve()),
    ),
    SingletonInjection<FetchApodsUseCase>(
      (resolver) => FetchApodsUseCaseImpl(
        apodsRepository: resolver.resolve(),
        apodsPaginationHandler: resolver.resolve(),
      ),
    ),
    FactoryInjection<ApodsListCubit>(
      (resolver) => ApodsListCubit(fetchApodsUseCase: resolver.resolve()),
    ),
  ];
}
