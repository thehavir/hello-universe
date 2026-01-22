import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/utils/dependency_injection/injection.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate_provider.dart';

void main() {
  testWidgets(
    '$InjectorDelegate can be obtained through ${InjectorDelegateProvider.of} method',
    (tester) async {
      final injectorDelegate = InjectorDelegate(Injector([]));
      Injector? gotInjector;
      final testWidget = InjectorDelegateProvider(
        injectorDelegate: injectorDelegate,
        child: Builder(
          builder: (context) {
            gotInjector = InjectorDelegateProvider.of(context);
            return const SizedBox();
          },
        ),
      );

      await tester.pumpWidget(testWidget);

      expect(gotInjector, injectorDelegate);
    },
  );

  testWidgets(
    'resolve extension method call the resolve method in $InjectorDelegate',
    (tester) async {
      const value = 'test';
      final resolverDelegate = InjectorDelegate(
        Injector([SingletonInjection<String>((resolver) => value)]),
      );
      String? gotValue;
      final testWidget = InjectorDelegateProvider(
        injectorDelegate: resolverDelegate,
        child: Builder(
          builder: (context) {
            gotValue = context.resolve<String>();
            return const SizedBox();
          },
        ),
      );

      await tester.pumpWidget(testWidget);

      expect(gotValue, value);
    },
  );

  testWidgets(
    'resolveWithParams extension method call the resolve method in $InjectorDelegate',
    (tester) async {
      final resolverDelegate = InjectorDelegate(
        Injector([
          AssistedFactoryInjection<String, int>(
            (resolver, params) => '$params',
          ),
        ]),
      );
      const number = 2042;
      String? gotValue;
      final testWidget = InjectorDelegateProvider(
        injectorDelegate: resolverDelegate,
        child: Builder(
          builder: (context) {
            gotValue = context.resolveWithParams<String, int>(number);
            return const SizedBox();
          },
        ),
      );

      await tester.pumpWidget(testWidget);

      expect(gotValue, '$number');
    },
  );
}
