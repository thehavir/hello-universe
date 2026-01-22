import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate_provider.dart';
import 'package:hello_universe/src/features/image_list/states/image_list_cubit.dart';
import 'package:hello_universe/src/navigation/paths.dart';
import 'package:hello_universe/src/navigation/router.dart';
import 'package:hello_universe/src/navigation/router_provider.dart';
import 'package:hello_universe/src/repository/base_repository.dart';

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
  Widget build(BuildContext context) => BlocProvider<ImageListCubit>(
    create: (_) => ImageListCubit(context.resolve<BaseRepository>()),
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
