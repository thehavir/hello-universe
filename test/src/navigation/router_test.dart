import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/features/image_detail/presentation/image_details_page.dart';
import 'package:hello_universe/src/features/image_full_screen/presentation/full_screen_image_page.dart';
import 'package:hello_universe/src/features/image_list/presentation/image_list_page.dart';
import 'package:hello_universe/src/features/image_list/states/image_list_cubit.dart';
import 'package:hello_universe/src/features/splash/presentation/splash_page.dart';
import 'package:hello_universe/src/models/models.dart';
import 'package:hello_universe/src/navigation/paths.dart';
import 'package:hello_universe/src/navigation/router.dart';
import 'package:hello_universe/src/navigation/router_provider.dart';
import 'package:hello_universe/src/navigation/routes.dart';

import '../../mixin/image_list_cubit_builder_mixin.dart';

late _ArrangeBuilder _builder;

void main() {
  setUp(() {
    _builder = _ArrangeBuilder();
  });

  test('is a $RouterProvider', () {
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

  group('route to $ImageListPage', () {
    test('has correct parameters', () {
      final tested = _builder.createTested();

      expect(
        tested.routes,
        contains(
          isA<GoRoute>()
              .having((p) => p.name, 'name', Routes.imageList)
              .having((p) => p.path, 'path', Paths.imageList),
        ),
      );
    });

    testWidgets('builds ImageListPage', (tester) async {
      await tester.pumpTested(initialRoute: Paths.imageList);

      expect(find.byType(ImageListPage), findsOneWidget);
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

class _ArrangeBuilder with ImageListCubitBuilderMixin {
  _ArrangeBuilder() {
    arrangeImageListCubit();
  }

  RouterProvider createTested() => const RealRouterProvider();
}

extension on WidgetTester {
  Future<void> pumpTested({GoRouter? routerConfig, String? initialRoute}) =>
      pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<ImageListCubit>(
              create: (_) => _builder.imageListCubit,
            ),
          ],
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
