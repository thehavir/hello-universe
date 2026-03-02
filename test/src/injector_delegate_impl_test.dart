import 'package:chopper/chopper.dart';
import 'package:chopper_built_value/chopper_built_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart' show testWidgets;
import 'package:hello_universe/src/data/api_config_interceptor.dart';
import 'package:hello_universe/src/data/apod_service.dart';
import 'package:hello_universe/src/injector_delegate_impl.dart';
import 'package:hello_universe/src/presentation/apod_details/apod_details_cubit.dart';
import 'package:hello_universe/src/router_provider_impl.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate.dart';
import 'package:hello_universe/src/utils/navigation/router_provider.dart';
import 'package:hello_universe/src/utils/uri_launcher/uri_launcher.dart';
import 'package:provider/provider.dart';
import 'package:test/test.dart';

late _ArrangeBuilder _builder;

void main() {
  setUp(() {
    _builder = _ArrangeBuilder();
  });

  test('can be created', () {
    final tested = _builder.createTested();

    expect(tested, isA<InjectorDelegateImpl>());
  });

  test('is a $InjectorDelegate', () {
    final tested = _builder.createTested();

    expect(tested, isA<InjectorDelegate>());
  });

  test('$ApodServiceProvider is injected', () {
    final tested = _builder.createTested();

    final injected = tested.resolve<ApodServiceProvider>();

    expect(injected, isA<ApodServiceProviderImpl>());
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

  // [CacheManager]'s [Config] is dependent on the [PlatformChannel] and
  // therefore it needs Flutter's [Widget] to be pumped to work and be testable.
  testWidgets('$ApodDetailsCubit is injected with the passed url', (
    tester,
  ) async {
    final tested = _builder.createTested();
    await tester.pumpWidget(
      Provider.value(value: tested, child: const SizedBox()),
    );

    final injected = tested.resolveWithParams<ApodDetailsCubit, String>('url');

    expect(injected, isA<ApodDetailsCubit>());
  });

  // [CacheManager]'s [Config] is dependent on the [PlatformChannel] and
  // therefore it needs Flutter's [Widget] to be pumped to work and be testable.
  testWidgets('$CacheManager is injected with the $Config', (tester) async {
    final tested = _builder.createTested();
    await tester.pumpWidget(
      Provider.value(value: tested, child: const SizedBox()),
    );

    final injected = tested.resolve<CacheManager>().config;

    expect(
      injected,
      isA<Config>()
          .having((p) => p.cacheKey, 'cacheKey', 'apodCacheManager')
          .having((p) => p.stalePeriod, 'stalePeriod', const Duration(days: 30))
          .having((p) => p.maxNrOfCacheObjects, 'maxNrOfCacheObjects', 1000),
    );
  });
}

class _ArrangeBuilder {
  InjectorDelegate createTested() => InjectorDelegateImpl();
}
