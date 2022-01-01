import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_universe/features/image_list/presentation/image_list_page.dart';
import 'package:hello_universe/features/image_list/states/image_list_cubit.dart';
import 'package:hello_universe/repository/impl_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Universe!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (_) => ImageListCubit(ImplRepository()),
        child: ImageListPage(),
      ),
    );
  }
}
