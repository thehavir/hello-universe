import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/domain/apods_error.dart';
import 'package:hello_universe/src/features/image_detail/presentation/image_details_page.dart';
import 'package:hello_universe/src/features/image_full_screen/presentation/full_screen_image_page.dart';
import 'package:hello_universe/src/features/splash/presentation/splash_page.dart';
import 'package:hello_universe/src/models/models.dart';
import 'package:hello_universe/src/paths.dart';
import 'package:hello_universe/src/presentation/apods_cubit.dart';
import 'package:hello_universe/src/presentation/apods_data.dart';
import 'package:hello_universe/src/presentation/apods_screen.dart';
import 'package:hello_universe/src/router.dart';
import 'package:hello_universe/src/utils/dependency_injection/injection.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate.dart';
import 'package:hello_universe/src/utils/navigation/router_provider.dart';
import 'package:hello_universe/src/routes.dart';
import 'package:hello_universe/src/utils/persistent_cubit_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'router_test.mocks.dart';

late _ArrangeBuilder _builder;

@GenerateNiceMocks([MockSpec<ApodsCubit>()])
void main() {
  setUp(() {
    _builder = _ArrangeBuilder();
  });

  test('is a $RouterProvider', () {
    provideDummy(const PersistentLoadingCubitState<ApodsData, ApodsError>());
    _builder.arrangeApodsCubit();
    final tested = _builder.createTested();

    expect(tested, isA<RouterProvider>());
  });

  group('route to $SplashPage', () {
    test('has correct parameters', () {
      final tested = _builder.createTested();

      expect(
        tested.routes,
        contains(
          isA<GoRoute>()
              .having((p) => p.name, 'name', Routes.splash)
              .having((p) => p.path, 'path', Paths.splash),
        ),
      );
    });

    testWidgets('builds SplashPage', (tester) async {
      await tester.pumpTested(initialRoute: Paths.splash);
      await tester.pump(const Duration(seconds: 4));

      expect(find.byType(SplashPage), findsOneWidget);
    });
  });

  group('route to $ApodsScreen', () {
    test('has correct parameters', () {
      final tested = _builder.createTested();

      expect(
        tested.routes,
        contains(
          isA<GoRoute>()
              .having((p) => p.name, 'name', Routes.apodsScreen)
              .having((p) => p.path, 'path', Paths.imageList),
        ),
      );
    });

    testWidgets('builds ImageListPage', (tester) async {
      await tester.pumpTested(initialRoute: Paths.imageList);

      expect(find.byType(ApodsScreen), findsOneWidget);
    });
  });

  group('route to $ImageDetailsPage', () {
    test('has correct parameters', () {
      final tested = _builder.createTested();

      expect(
        tested.routes,
        contains(
          isA<GoRoute>()
              .having((p) => p.name, 'name', Routes.imageDetails)
              .having((p) => p.path, 'path', Paths.imageDetails),
        ),
      );
    });

    testWidgets('builds ImageDetailsPage', (tester) async {
      final apod = Apod(title: 'abc', url: 'abcd');
      final router = GoRouter(
        initialLocation: Paths.imageList,
        routes: const RealRouterProvider().routes,
      );
      await tester.pumpTested(routerConfig: router);

      router.goNamed(Routes.imageDetails, extra: apod);
      await tester.pumpAndSettle();

      expect(find.byType(ImageDetailsPage), findsOneWidget);
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
        initialLocation: Paths.imageList,
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
  _ArrangeBuilder();

  final apodsCubit = MockApodsCubit();

  void arrangeApodsCubit() {
    when(apodsCubit.state).thenAnswer(
      (_) => const PersistentLoadingCubitState<ApodsData, ApodsError>(),
    );
    when(apodsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(apodsCubit.close()).thenAnswer((_) async {});
    when(apodsCubit.fetchApods()).thenAnswer((_) async {});
  }

  RouterProvider createTested() => const RealRouterProvider();
}

extension on WidgetTester {
  Future<void> pumpTested({GoRouter? routerConfig, String? initialRoute}) {
    final injector = InjectorDelegate(
      Injector([
        FactoryInjection<ApodsCubit>((resolver) => _builder.apodsCubit),
      ]),
    );

    return pumpWidget(
      Provider.value(
        value: injector,
        child: MaterialApp.router(
          routerConfig:
              routerConfig ??
              GoRouter(
                initialLocation: initialRoute ?? Paths.splash,
                routes: const RealRouterProvider().routes,
              ),
        ),
      ),
    );
  }
}
