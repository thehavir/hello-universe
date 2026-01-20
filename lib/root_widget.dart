import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/features/image_list/states/image_list_cubit.dart';
import 'package:hello_universe/repository/repository.dart';
import 'package:hello_universe/src/navigation/paths.dart';
import 'package:hello_universe/src/navigation/router.dart';
import 'package:hello_universe/src/navigation/router_provider.dart';

class RootWidget extends StatefulWidget {
  @override
  State<RootWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  late final RouterProvider _routerProvider;

  @override
  void initState() {
    super.initState();

    _routerProvider = RealRouterProvider();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider<ImageListCubit>(
        create: (_) => ImageListCubit(ImplRepository()),
      ),
    ],
    child: MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: Paths.splash,
        routes: _routerProvider.routes,
      ),
      title: 'Hello Universe!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    ),
  );
}
