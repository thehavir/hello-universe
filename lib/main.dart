import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_universe/features/image_list/states/image_list_cubit.dart';
import 'package:hello_universe/repository/impl_repository.dart';
import 'package:hello_universe/utils/navigation/app_navigator.dart';
import 'package:hello_universe/utils/navigation/states/navigation_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Universe!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<NavigationCubit>(
            create: (_) => NavigationCubit(),
          ),
          BlocProvider<ImageListCubit>(
            create: (_) => ImageListCubit(ImplRepository()),
          ),
        ],
        child: WillPopScope(
          // In order to prevent closing app when back button is pressed.
          // Inspired from here:
          // https://github.com/flutter/flutter/issues/66349.
          // Todo(Havir): Make use of [BackButtonDispatcher] instead.
          onWillPop: () async => !await _navigatorKey.currentState!.maybePop(),
          child: AppNavigator(
            navigatorKey: _navigatorKey,
          ),
        ),
      ),
    );
  }
}
