import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/assets.dart';
import 'package:hello_universe/src/routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Start fetch the image list.
    _setTimer(context);

    return Image.asset(Assets.splash, fit: BoxFit.cover);
  }

  void _setTimer(BuildContext context) => Timer(
    const Duration(seconds: 1),
    () => context.goNamed(Routes.apodsScreen),
  );
}
