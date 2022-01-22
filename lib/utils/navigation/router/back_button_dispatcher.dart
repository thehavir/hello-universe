import 'package:flutter/material.dart';

import 'router_delegate.dart';

/// This app's `BackButtonDispatcher`.
class AppBackButtonDispatcher extends RootBackButtonDispatcher {
  /// Constructs a `AppBackButtonDispatcher`.
  AppBackButtonDispatcher(this.routerDelegate);

  /// Helps you link the dispatcher to the app's RouterDelegate, i.e.
  /// `AppRouterDelegate`.
  final AppRouterDelegate routerDelegate;

  /// Delegates didPopRoute to _routerDelegate.
  @override
  Future<bool> didPopRoute() => routerDelegate.popRoute();
}
