import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/features/image_detail/image_details_page.dart';
import 'package:hello_universe/src/features/image_full_screen/full_screen_image_page.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_screen.dart';
import 'package:hello_universe/src/utils/navigation/nullable_object_extension.dart';
import 'package:hello_universe/src/paths.dart';
import 'package:hello_universe/src/utils/navigation/router_provider.dart';
import 'package:hello_universe/src/routes.dart';

class RealRouterProvider implements RouterProvider {
  const RealRouterProvider();

  @override
  List<RouteBase> get routes => [
    GoRoute(
      name: Routes.apodsListScreen,
      path: Paths.apodsListScreen,
      builder: (_, __) => const ApodsListScreen(),
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
