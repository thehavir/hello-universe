import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/paths.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate_provider.dart';
import 'package:hello_universe/src/utils/navigation/router_provider.dart';

final _navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root-navigator');

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      _Consumer(routerProvider: context.resolve<RouterProvider>());
}

class _Consumer extends StatelessWidget {
  const _Consumer({required this.routerProvider});

  final RouterProvider routerProvider;

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    routerConfig: GoRouter(
      navigatorKey: _navigatorKey,
      initialLocation: Paths.apodsListScreen,
      routes: routerProvider.routes,
    ),
    title: 'Hello Universe',
  );
}
