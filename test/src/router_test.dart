import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/domain/apods_error.dart';
import 'package:hello_universe/src/presentation/apod_details/apod_details_screen.dart';
import 'package:hello_universe/src/features/image_full_screen/full_screen_image_page.dart';
import 'package:hello_universe/src/paths.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_cubit.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_data.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_screen.dart';
import 'package:hello_universe/src/router.dart';
import 'package:hello_universe/src/utils/dependency_injection/injection.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate.dart';
import 'package:hello_universe/src/utils/navigation/router_provider.dart';
import 'package:hello_universe/src/routes.dart';
import 'package:hello_universe/src/utils/persistent_cubit_state.dart';
import 'package:hello_universe/src/utils/uri_launcher/uri_launcher.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../test_doubles/test_models.dart';
import 'router_test.mocks.dart';

late _ArrangeBuilder _builder;

@GenerateNiceMocks([MockSpec<ApodsListCubit>(), MockSpec<UriLauncher>()])
void main() {
  provideDummy<PersistentCubitState<ApodsListData, ApodsError>>(
    const PersistentLoadingCubitState(),
  );

  setUp(() {
    _builder = _ArrangeBuilder();
  });

  test('is a $RouterProvider', () {
    final tested = _builder.createTested();

    expect(tested, isA<RouterProvider>());
  });

  group('route to $ApodsListScreen', () {
    test('has correct parameters', () {
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

    testWidgets('builds ImageListPage', (tester) async {
      await tester.pumpTested(initialRoute: Paths.apodsListScreen);

      expect(find.byType(ApodsListScreen), findsOneWidget);
    });
  });

  group('route to $ApodDetailsScreen', () {
    test('has correct parameters', () {
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

    testWidgets('builds ApodDetailsScreen', (tester) async {
      final apod = TestModels.apod(title: 'aa2');
      final router = GoRouter(
        initialLocation: Paths.apodsListScreen,
        routes: const RealRouterProvider().routes,
      );
      await tester.pumpTested(routerConfig: router);

      router.goNamed(Routes.apodDetailsScreen, extra: apod);
      await tester.pumpAndSettle();

      expect(find.byType(ApodDetailsScreen), findsOneWidget);
    });
  });

  group('route to $FullScreenImagePage', () {
    test('has correct parameters', () {
      final tested = _builder.createTested();

      expect(
        tested.routes,
        contains(
          isA<GoRoute>()
              .having((p) => p.name, 'name', Routes.imageFullScreen)
              .having((p) => p.path, 'path', Paths.imageFullScreen),
        ),
      );
    });

    testWidgets('builds FullScreenImagePage', (tester) async {
      final router = GoRouter(
        initialLocation: Paths.apodsListScreen,
        routes: const RealRouterProvider().routes,
      );
      await tester.pumpTested(routerConfig: router);

      router.goNamed(Routes.imageFullScreen, extra: 'url');
      await tester.pumpAndSettle();

      expect(find.byType(FullScreenImagePage), findsOneWidget);
    });
  });
}

class _ArrangeBuilder {
  final apodsCubit = MockApodsListCubit();
  final uriLauncher = MockUriLauncher();

  RouterProvider createTested() => const RealRouterProvider();
}

extension on WidgetTester {
  Future<void> pumpTested({GoRouter? routerConfig, String? initialRoute}) =>
      pumpWidget(
        Provider.value(
          value: InjectorDelegate(
            Injector([
              FactoryInjection<ApodsListCubit>((_) => _builder.apodsCubit),
              SingletonInjection<UriLauncher>((_) => _builder.uriLauncher),
            ]),
          ),
          child: MaterialApp.router(
            routerConfig:
                routerConfig ??
                GoRouter(
                  initialLocation: initialRoute ?? Paths.apodsListScreen,
                  routes: const RealRouterProvider().routes,
                ),
          ),
        ),
      );
}
