import 'package:chopper/chopper.dart';
import 'package:chopper_built_value/chopper_built_value.dart';
import 'package:hello_universe/src/data/api_config_interceptor.dart';
import 'package:hello_universe/src/data/apod_service.dart';
import 'package:hello_universe/src/real_injector_delegate.dart';
import 'package:hello_universe/src/router_provider_impl.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate.dart';
import 'package:hello_universe/src/utils/navigation/router_provider.dart';
import 'package:hello_universe/src/utils/uri_launcher/uri_launcher.dart';
import 'package:test/test.dart';

late _ArrangeBuilder _builder;

void main() {
  setUp(() {
    _builder = _ArrangeBuilder();
  });

  test('can be created', () {
    final tested = _builder.createTested();

    expect(tested, isA<RealInjectorDelegate>());
  });

  test('is a $InjectorDelegate', () {
    final tested = _builder.createTested();

    expect(tested, isA<InjectorDelegate>());
  });

  test('$ApodServiceProvider is injected', () {
    final tested = _builder.createTested();

    final injected = tested.resolve<ApodServiceProvider>();

    expect(injected, isA<RealApodServiceProvider>());
  });

  test('$ApodService is injected', () {
    final tested = _builder.createTested();

    final injected = tested.resolve<ApodService>();

    expect(injected, isA<ApodService>());
  });

  group('$ChopperClient', () {
    test('is injected', () {
      final tested = _builder.createTested();

      final injected = tested.resolve<ChopperClient>();

      expect(injected, isA<ChopperClient>());
    });

    test('has correct base url', () {
      final tested = _builder.createTested();

      final injected = tested.resolve<ChopperClient>();

      expect(injected.baseUrl, Uri.parse('https://api.nasa.gov/'));
    });

    test('has $BuiltValueConverter converter', () {
      final tested = _builder.createTested();

      final injected = tested.resolve<ChopperClient>();

      expect(injected.converter, isA<BuiltValueConverter>());
    });

    test('has $ConfigRequestInterceptor as $Interceptor', () {
      final tested = _builder.createTested();

      final injected = tested.resolve<ChopperClient>();

      expect(injected.interceptors, [isA<ConfigRequestInterceptor>()]);
    });
  });

  test('$ConfigRequestInterceptor is injected', () {
    final tested = _builder.createTested();

    final injected = tested.resolve<ConfigRequestInterceptor>();

    expect(injected, isA<ConfigRequestInterceptorImpl>());
  });

  test('$UriLauncher is injected', () {
    final tested = _builder.createTested();

    final injected = tested.resolve<UriLauncher>();

    expect(injected, isA<UriLauncherImpl>());
  });

  test('$RouterProvider is injected', () {
    final tested = _builder.createTested();

    final injected = tested.resolve<RouterProvider>();

    expect(injected, isA<RouterProviderImpl>());
  });
}

class _ArrangeBuilder {
  RealInjectorDelegate createTested() => RealInjectorDelegate();
}
