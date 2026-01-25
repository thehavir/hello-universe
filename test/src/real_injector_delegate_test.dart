import 'package:chopper/chopper.dart';
import 'package:chopper_built_value/chopper_built_value.dart';
import 'package:hello_universe/src/data/apod_service.dart';
import 'package:hello_universe/src/real_injector_delegate.dart';
import 'package:hello_universe/src/repository/base_repository.dart';
import 'package:hello_universe/src/repository/impl_repository.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate.dart';
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

  test('$BaseRepository is injected', () {
    final tested = _builder.createTested();

    final injected = tested.resolve<BaseRepository>();

    expect(injected, isA<ImplRepository>());
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
  });
}

class _ArrangeBuilder {
  RealInjectorDelegate createTested() => RealInjectorDelegate();
}
