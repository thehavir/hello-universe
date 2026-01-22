import 'package:flutter/material.dart' hide RootWidget;
import 'package:hello_universe/src/real_injector_delegate.dart';
import 'package:hello_universe/src/root_widget.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate_provider.dart';

void main() {
  final injector = RealInjectorDelegate();

  runApp(
    InjectorDelegateProvider(
      injectorDelegate: injector,
      child: const RootWidget(),
    ),
  );
}
