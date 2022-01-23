import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_universe/features/core/assets.dart';
import 'package:hello_universe/features/image_list/states/image_list_cubit.dart';
import 'package:hello_universe/utils/navigation/states/navigation_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Start fetch the image list.
    context.read<ImageListCubit>().fetch();

    _setTimer(context);

    return Container(
      child: Image.asset(
        Assets.splash,
        fit: BoxFit.cover,
      ),
    );
  }

  void _setTimer(BuildContext context) => Timer(
        const Duration(seconds: 3),
        () => context.read<NavigationCubit>().navigateToImageListPage(),
      );
}
