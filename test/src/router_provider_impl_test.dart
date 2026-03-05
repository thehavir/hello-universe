import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/paths.dart';
import 'package:hello_universe/src/presentation/apod_details/apod_details_screen.dart';
import 'package:hello_universe/src/presentation/apod_full_size/apod_full_size_screen.dart';
import 'package:hello_universe/src/presentation/apod_full_size/apod_full_size_screen_arguments.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_screen.dart';
import 'package:hello_universe/src/router_provider_impl.dart';
import 'package:hello_universe/src/routes.dart';
import 'package:hello_universe/src/utils/navigation/router_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../test_doubles/test_models.dart';
import '../test_utils/mock_context.mocks.dart';
import 'router_provider_impl_test.mocks.dart';

late _ArrangeBuilder _builder;

@GenerateNiceMocks([MockSpec<GoRouterState>()])
void main() {
  setUp(() => _builder = _ArrangeBuilder());

  test('can be created', () {
    final tested = _builder.createTested();

    expect(tested, isA<RouterProviderImpl>());
  });

  test('has ${Routes.apodsListScreen}', () {
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

  test('${Routes.apodsListScreen} builds $ApodsListScreen', () {
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

  test('has ${Routes.apodDetailsScreen}', () {
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

  test('${Routes.apodDetailsScreen} builds $ApodDetailsScreen '
      'with $Apod as extra', () {
    final apod = TestModels.apod(title: 'Andromeda');
    when(_builder.goRouterState.extra).thenAnswer((_) => apod);
    final tested = _builder.createTested();

    final route = tested.routes.firstWhere(
      (route) => route.name == Routes.apodDetailsScreen,
    );
    final widget =
        route.pageBuilder?.call(_builder.context, _builder.goRouterState)
            as CustomTransitionPage;
    expect(
      widget.child,
      isA<ApodDetailsScreen>().having((p) => p.apod, 'apod', apod),
    );
  });

  test('${Routes.apodDetailsScreen} has a $CustomTransitionPage '
      'with opaque false and 200 millisecond reverseTransitionDuration', () {
    final apod = TestModels.apod(title: 'Andromeda');
    when(_builder.goRouterState.extra).thenAnswer((_) => apod);
    final tested = _builder.createTested();

    final route = tested.routes.firstWhere(
      (route) => route.name == Routes.apodDetailsScreen,
    );
    final widget = route.pageBuilder?.call(
      _builder.context,
      _builder.goRouterState,
    );
    expect(
      widget,
      isA<CustomTransitionPage>()
          .having((p) => p.opaque, 'opaque', isFalse)
          .having(
            (p) => p.reverseTransitionDuration,
            'reverseTransitionDuration',
            const Duration(milliseconds: 200),
          ),
    );
  });

  test(
    '${Routes.apodDetailsScreen}\'s $CustomTransitionPage '
    'has $FadeTransition as transitionBuilder with the child and animation',
    () {
      final animation = _builder.animation;
      const child = Text('child');
      final apod = TestModels.apod(title: 'Andromeda');
      when(_builder.goRouterState.extra).thenAnswer((_) => apod);
      final tested = _builder.createTested();

      final route = tested.routes.firstWhere(
        (route) => route.name == Routes.apodDetailsScreen,
      );
      final page =
          route.pageBuilder?.call(_builder.context, _builder.goRouterState)
              as CustomTransitionPage;
      final widget = page.transitionsBuilder.call(
        _builder.context,
        animation,
        _builder.animation,
        child,
      );
      expect(
        widget,
        isA<FadeTransition>()
            .having((p) => p.opacity, 'opacity', animation)
            .having((p) => p.child, 'child', child),
      );
    },
  );

  test('has ${Routes.apodFullSizeScreen}', () {
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

  test('${Routes.apodFullSizeScreen} builds $ApodFullSizeScreen '
      'with $ApodFullSizeScreenArguments as extra', () {
    final arguments = TestModels.apodFullSizeScreenArguments();
    when(_builder.goRouterState.extra).thenAnswer((_) => arguments);
    final tested = _builder.createTested();

    final route = tested.routes.firstWhere(
      (route) => route.name == Routes.apodFullSizeScreen,
    );
    final widget =
        route.pageBuilder?.call(_builder.context, _builder.goRouterState)
            as CustomTransitionPage;
    expect(
      widget.child,
      isA<ApodFullSizeScreen>().having(
        (p) => p.arguments,
        'arguments',
        arguments,
      ),
    );
  });

  test('${Routes.apodFullSizeScreen} has a $CustomTransitionPage '
      'with opaque false and 200 millisecond reverseTransitionDuration', () {
    final arguments = TestModels.apodFullSizeScreenArguments();
    when(_builder.goRouterState.extra).thenAnswer((_) => arguments);
    final tested = _builder.createTested();

    final route = tested.routes.firstWhere(
      (route) => route.name == Routes.apodFullSizeScreen,
    );
    final widget = route.pageBuilder?.call(
      _builder.context,
      _builder.goRouterState,
    );
    expect(
      widget,
      isA<CustomTransitionPage>()
          .having((p) => p.opaque, 'opaque', isFalse)
          .having(
            (p) => p.reverseTransitionDuration,
            'reverseTransitionDuration',
            const Duration(milliseconds: 200),
          ),
    );
  });

  test(
    '${Routes.apodFullSizeScreen}\'s $CustomTransitionPage '
    'has $FadeTransition as transitionBuilder with the child and animation',
    () {
      final animation = _builder.animation;
      const child = Text('child');
      final arguments = TestModels.apodFullSizeScreenArguments();
      when(_builder.goRouterState.extra).thenAnswer((_) => arguments);
      final tested = _builder.createTested();

      final route = tested.routes.firstWhere(
        (route) => route.name == Routes.apodFullSizeScreen,
      );
      final page =
          route.pageBuilder?.call(_builder.context, _builder.goRouterState)
              as CustomTransitionPage;
      final widget = page.transitionsBuilder.call(
        _builder.context,
        animation,
        _builder.animation,
        child,
      );
      expect(
        widget,
        isA<FadeTransition>()
            .having((p) => p.opacity, 'opacity', animation)
            .having((p) => p.child, 'child', child),
      );
    },
  );
}

class _ArrangeBuilder {
  final context = MockBuildContext();
  final goRouterState = MockGoRouterState();
  final animation = MockAnimation();

  RouterProvider createTested() => const RouterProviderImpl();
}

class MockAnimation extends Mock implements Animation<double> {}
