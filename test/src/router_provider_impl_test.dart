import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/paths.dart';
import 'package:hello_universe/src/presentation/apod_details/apod_details_screen.dart';
import 'package:hello_universe/src/presentation/apod_full_size/apod_full_size_screen.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_screen.dart';
import 'package:hello_universe/src/router_provider_impl.dart';
import 'package:hello_universe/src/routes.dart';
import 'package:hello_universe/src/utils/navigation/router_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_doubles/test_models.dart';
import 'router_provider_impl_test.mocks.dart';

late _ArrangeBuilder _builder;

@GenerateNiceMocks([MockSpec<BuildContext>(), MockSpec<GoRouterState>()])
void main() {
  setUp(() => _builder = _ArrangeBuilder());

  testWidgets('can be created', (tester) async {
    final tested = _builder.createTested();

    expect(tested, isA<RouterProviderImpl>());
  });

  testWidgets('has ${Routes.apodsListScreen}', (tester) async {
    final tested = _builder.createTested();

    expect(
      tested.routes,
      contains(
        isA<GoRoute>()
            .having((p) => p.name, 'name', Routes.apodsListScreen)
            .having((p) => p.path, 'path', Paths.apodsListScreen),
      ),
    );
  });

  testWidgets('${Routes.apodsListScreen} builds $ApodsListScreen', (
    tester,
  ) async {
    final tested = _builder.createTested();

    final route = tested.routes.firstWhere(
      (route) => route.name == Routes.apodsListScreen,
    );
    final widget = route.builder?.call(
      _builder.context,
      _builder.goRouterState,
    );

    expect(widget, isA<ApodsListScreen>());
  });

  testWidgets('has ${Routes.apodDetailsScreen}', (tester) async {
    final tested = _builder.createTested();

    expect(
      tested.routes,
      contains(
        isA<GoRoute>()
            .having((p) => p.name, 'name', Routes.apodDetailsScreen)
            .having((p) => p.path, 'path', Paths.apodDetailsScreen),
      ),
    );
  });

  testWidgets('${Routes.apodDetailsScreen} builds $ApodDetailsScreen '
      'with $Apod as extra', (tester) async {
    final apod = TestModels.apod(title: 'Andromeda');
    when(_builder.goRouterState.extra).thenAnswer((_) => apod);
    final tested = _builder.createTested();

    final route = tested.routes.firstWhere(
      (route) => route.name == Routes.apodDetailsScreen,
    );
    final widget = route.builder?.call(
      _builder.context,
      _builder.goRouterState,
    );

    expect(
      widget,
      isA<ApodDetailsScreen>().having((p) => p.apod, 'apod', apod),
    );
  });

  testWidgets('has ${Routes.apodFullSizeScreen}', (tester) async {
    final tested = _builder.createTested();

    expect(
      tested.routes,
      contains(
        isA<GoRoute>()
            .having((p) => p.name, 'name', Routes.apodFullSizeScreen)
            .having((p) => p.path, 'path', Paths.apodFullSizeScreen),
      ),
    );
  });

  testWidgets('${Routes.apodFullSizeScreen} builds $ApodFullSizeScreen', (
    tester,
  ) async {
    const url = 'trisquel.info';
    when(_builder.goRouterState.extra).thenAnswer((_) => url);
    final tested = _builder.createTested();

    final route = tested.routes.firstWhere(
      (route) => route.name == Routes.apodFullSizeScreen,
    );
    final widget = route.builder?.call(
      _builder.context,
      _builder.goRouterState,
    );

    expect(widget, isA<ApodFullSizeScreen>().having((p) => p.url, 'url', url));
  });
}

class _ArrangeBuilder {
  final context = MockBuildContext();
  final goRouterState = MockGoRouterState();

  RouterProvider createTested() => const RouterProviderImpl();
}
