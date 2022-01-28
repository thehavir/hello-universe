import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_universe/features/image_list/states/image_list_cubit.dart';
import 'package:hello_universe/repository/repository.dart';
import 'package:hello_universe/utils/navigation/navigation.dart';

class RootWidget extends StatefulWidget {
  @override
  State<RootWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late AppRouterDelegate _routerDelegate;
  late AppBackButtonDispatcher _backButtonDispatcher;
  late NavigationCubit _navigationCubit;

  @override
  void initState() {
    super.initState();

    _navigationCubit = NavigationCubit();
    _routerDelegate = AppRouterDelegate(
      navigatorKey: _navigatorKey,
      navigationCubit: _navigationCubit,
    );
    _backButtonDispatcher = AppBackButtonDispatcher(_routerDelegate);

    _routerDelegate.setNewRoutePath(splashPageConfig);
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<NavigationCubit>(
            create: (_) => _navigationCubit,
          ),
          BlocProvider<ImageListCubit>(
            create: (_) => ImageListCubit(ImplRepository()),
          ),
        ],
        child: MaterialApp(
          title: 'Hello Universe!',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: _buildHome(),
        ),
      );

  Widget _buildHome() => BlocBuilder<NavigationCubit, NavigationState>(
        builder: (BuildContext context, NavigationState state) => Router(
          routerDelegate: _routerDelegate,
          backButtonDispatcher: _backButtonDispatcher,
        ),
      );
}
