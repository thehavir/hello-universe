import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/paths.dart';
import 'package:hello_universe/src/router.dart';
import 'package:hello_universe/src/utils/navigation/router_provider.dart';

class RootWidget extends StatefulWidget {
  const RootWidget({super.key});

  @override
  State<RootWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  late final RouterProvider _routerProvider;

  @override
  void initState() {
    super.initState();

    _routerProvider = const RealRouterProvider();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    routerConfig: GoRouter(
      initialLocation: Paths.splash,
      routes: _routerProvider.routes,
    ),
    title: 'Hello Universe!',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  );
}
