import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/presentation/apod_details/apod_details_screen.dart';
import 'package:hello_universe/src/presentation/apod_full_size/apod_full_size_screen.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_screen.dart';
import 'package:hello_universe/src/utils/navigation/nullable_object_extension.dart';
import 'package:hello_universe/src/paths.dart';
import 'package:hello_universe/src/utils/navigation/router_provider.dart';
import 'package:hello_universe/src/routes.dart';

class RouterProviderImpl implements RouterProvider {
  const RouterProviderImpl();

  @override
  List<GoRoute> get routes => [
    GoRoute(
      name: Routes.apodsListScreen,
      path: Paths.apodsListScreen,
      builder: (_, __) => const ApodsListScreen(),
    ),
    GoRoute(
      name: Routes.apodDetailsScreen,
      path: Paths.apodDetailsScreen,
      pageBuilder: (_, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: ApodDetailsScreen(apod: state.extra.forceCast()),
        opaque: false,
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      name: Routes.apodFullSizeScreen,
      path: Paths.apodFullSizeScreen,
      pageBuilder: (_, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: ApodFullSizeScreen(arguments: state.extra.forceCast()),
        opaque: false,
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
  ];
}
