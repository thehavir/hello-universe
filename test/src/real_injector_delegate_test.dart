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
}

class _ArrangeBuilder {
  RealInjectorDelegate createTested() => RealInjectorDelegate();
}
