import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/features/image_detail/presentation/image_details_page.dart';
import 'package:hello_universe/src/features/image_full_screen/presentation/full_screen_image_page.dart';
import 'package:hello_universe/src/features/image_list/presentation/image_list_page.dart';
import 'package:hello_universe/src/features/splash/presentation/splash_page.dart';
import 'package:hello_universe/src/navigation/nullable_object_extension.dart';
import 'package:hello_universe/src/navigation/paths.dart';
import 'package:hello_universe/src/navigation/router_provider.dart';
import 'package:hello_universe/src/navigation/routes.dart';

class RealRouterProvider implements RouterProvider {
  const RealRouterProvider();

  @override
  List<RouteBase> get routes => [
    GoRoute(
      name: Routes.splash,
      path: Paths.splash,
      builder: (_, __) => const SplashPage(),
    ),
    GoRoute(
      name: Routes.imageList,
      path: Paths.imageList,
      builder: (_, __) => const ImageListPage(),
    ),
    GoRoute(
      name: Routes.imageDetails,
      path: Paths.imageDetails,
      builder: (_, state) => ImageDetailsPage(apod: state.extra.forceCast()),
    ),
    GoRoute(
      name: Routes.imageFullScreen,
      path: Paths.imageFullScreen,
      builder: (_, state) => FullScreenImagePage(state.extra.forceCast()),
    ),
  ];
}
