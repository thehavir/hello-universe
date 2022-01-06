import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

/// A wrapper for all of widget test's widgets.
class TestWidgetsWrapper extends StatelessWidget {
  /// Constructs a `TestWidgetsWrapper`.
  const TestWidgetsWrapper({
    @required this.child,
  });

  /// Child widget that `TestWidgetsWrapper` wraps it.
  final Widget? child;

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: child,
        ),
        navigatorObservers: <NavigatorObserver>[MockNavigatorObserver()],
      );
}
