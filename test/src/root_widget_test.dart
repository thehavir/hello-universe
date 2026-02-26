import 'package:flutter/material.dart' hide RootWidget;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/paths.dart';
import 'package:hello_universe/src/root_widget.dart';
import 'package:hello_universe/src/utils/dependency_injection/injection.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate.dart';
import 'package:hello_universe/src/utils/navigation/router_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'root_widget_test.mocks.dart';

late MockRouterProvider _routerProvider;

@GenerateNiceMocks([MockSpec<RouterProvider>()])
void main() {
  setUp(() => _routerProvider = MockRouterProvider());

  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(RootWidget), findsOneWidget);
  });

  testWidgets('has $MaterialApp', (tester) async {
    await tester.pumpTested();

    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('$MaterialApp has title', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(widget.title, 'Hello Universe');
  });

  testWidgets('$MaterialApp has a $GoRouter as routerConfig', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(widget.routerConfig, isA<GoRouter>());
  });

  testWidgets('sets a $GlobalKey with label for the $GoRouter', (tester) async {
    await tester.pumpTested();

    final routerConfig =
        tester.widget<MaterialApp>(find.byType(MaterialApp)).routerConfig
            as GoRouter;
    expect(
      routerConfig.configuration.navigatorKey,
      isA<LabeledGlobalKey<NavigatorState>>().having(
        (p) => p.toString(),
        'key',
        contains('root-navigator'),
      ),
    );
  });

  testWidgets('$GoRouter routes is set by routes on the $RouterProvider', (
    tester,
  ) async {
    final routes = [
      GoRoute(
        name: 'route-1',
        path: '/route-1',
        builder: (_, __) => const Text('route-1'),
      ),
    ];
    when(_routerProvider.routes).thenAnswer((_) => routes);

    await tester.pumpTested();

    final routerConfig =
        tester.widget<MaterialApp>(find.byType(MaterialApp)).routerConfig
            as GoRouter;
    expect(routerConfig.configuration.routes, routes);
  });

  testWidgets('$GoRouter initial location set to ${Paths.apodsListScreen}', (
    tester,
  ) async {
    await tester.pumpTested();

    final routerConfig =
        tester.widget<MaterialApp>(find.byType(MaterialApp)).routerConfig
            as GoRouter;
    expect(
      routerConfig.routeInformationProvider.value.uri.path,
      Paths.apodsListScreen,
    );
  });
}

extension on WidgetTester {
  Future<void> pumpTested() => pumpWidget(
    Provider.value(
      value: InjectorDelegate(
        Injector([SingletonInjection<RouterProvider>((_) => _routerProvider)]),
      ),
      child: const RootWidget(),
    ),
  );
}
